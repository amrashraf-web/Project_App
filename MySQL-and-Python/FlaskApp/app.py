import mysql.connector
from flask import Flask, render_template, json, request, redirect, session
import os
import secrets
from mysql.connector import Error
import traceback
app = Flask(__name__)
setup_done = False
# Set a secret key for the session
app.secret_key = secrets.token_hex(16)

# Function to execute SQL scripts from files

def execute_sql_file(file_path):
    with open(file_path, 'r') as file:
        sql_commands = file.read()
        conn = get_mysql_connection()
        cursor = conn.cursor()
        cursor.execute(sql_commands, multi=True)
        conn.commit()
        cursor.close()
        conn.close()
        traceback.print_exc()


def get_mysql_connection():
    return mysql.connector.connect(
        host=os.environ['DB_HOST'],
        port=int(os.environ['DB_PORT']),
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'],
        database=os.environ['DB_NAME']
    )


@app.before_request
def setup_database():
    global setup_done
    if not setup_done:
        try:
            # Execute BucketList.txt script to create the database
            execute_sql_file('BucketList.txt')
        except:
            pass
        try:
            # Execute sp_createUser.txt script to create the stored procedure
            execute_sql_file('sp_createUser.txt')
        except:
            pass
        try:
            # Execute sp_createUser.txt script to create the stored procedure
            execute_sql_file('sp_validateLogin.txt')
        except:
            pass
        try:
            # Execute tbl_wish.sql script to create the tbl_wish table
            execute_sql_file('tbl_wish.sql')
        except:
            pass
        try:
            # Execute sp_addWish.txt script to create the stored procedure
            execute_sql_file('sp_addWish.txt')
        except:
            pass
        setup_done = True


@app.route("/")
def main():
    return render_template('index.html')

@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')



@app.route('/signUp', methods=['POST', 'GET'])
def signUp():
    # read the posted values from the UI
    _name = request.form['inputName']
    _email = request.form['inputEmail']
    _password = request.form['inputPassword']

    # validate the received values
    if _name and _email and _password:
        conn = get_mysql_connection()
        cursor = conn.cursor()
        try:
            # Check if the email already exists
            cursor.execute("SELECT user_id FROM tbl_user WHERE user_username = %s", (_email,))
            data = cursor.fetchone()

            if data:
                return json.dumps({'message':'Email already exists!'})
            else:
                # Insert the new user into the database
                cursor.execute(
                    "INSERT INTO tbl_user (user_name, user_username, user_password) VALUES (%s, %s, %s)",
                    (_name, _email, _password))
                conn.commit()
                return json.dumps({'message':'User created successfully !'})
        except Exception as e:
            traceback.print_exc()
            return json.dumps({'html':'<span>Enter the required fields</span>'}) 
        finally:
            # Consume the result from the SELECT query and close the cursor and connection in the 'finally' block
            cursor.fetchall()
            cursor.close()
            conn.close()
    else:
        return render_template('check.html', error='Enter the required fields')




@app.route('/showSignIn')
def showSignin():
    return render_template('signin.html')

@app.route('/validateLogin', methods=['POST'])
def validateLogin():
    try:
        _email = request.form['inputEmail']
        _password = request.form['inputPassword']

        conn = get_mysql_connection()
        cursor = conn.cursor()

        # Validate user login
        cursor.execute("SELECT user_id, user_password FROM tbl_user WHERE user_username = %s", (_email,))
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        if data:
            user_id, mypassword = data
            if str(mypassword) == str(_password):
                session['user'] = user_id
                return redirect('/userHome')
            else:
                return render_template('error.html', error='Invalid email or password')
        else:
            return render_template('error.html', error='User does not exist')
    except Exception as e:
        traceback.print_exc()
        return render_template('error.html', error=f'An error occurred: {e}')


@app.route('/userHome')
def userHome():
    if session.get('user'):
        return render_template('userHome.html')
    else:
        return render_template('error.html',error = 'Unauthorized Access')

@app.route('/logout')
def logout():
    session.pop('user',None)
    return redirect('/')

@app.route('/showAddWish')
def showAddWish():
    return render_template('addWish.html')

@app.route('/addWish', methods=['POST'])
def addWish():
    try:
        if session.get('user'):
            _title = request.form['inputTitle']
            _description = request.form['inputDescription']
            _user = session.get('user')

            conn = get_mysql_connection()
            cursor = conn.cursor()
            cursor.callproc('sp_addWish', (_title, _description, _user))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect('/userHome')
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getWish')
def getWish():
    try:
        if session.get('user'):
            _user = session.get('user')
 
            conn = get_mysql_connection()
            cursor = conn.cursor()
            cursor.callproc('sp_GetWishByUser',(_user,))
            wishes = cursor.fetchall()
 
            wishes_dict = []
            for wish in wishes:
                wish_dict = {
                        'Id': wish[0],
                        'Title': wish[1],
                        'Description': wish[2],
                        'Date': wish[4]}
                wishes_dict.append(wish_dict)
 
            # Close the cursor and connection
            cursor.close()
            conn.close()
            return render_template('wishes.html', wishes=wishes_dict)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
