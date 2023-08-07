from flask import Flask, render_template, json, request, redirect, session
from flaskext.mysql import MySQL
import os
import subprocess
app = Flask(__name__)

mysql = MySQL()

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = os.environ['DB_USER']
app.config['MYSQL_DATABASE_PASSWORD'] = os.environ['DB_PASSWORD']
app.config['MYSQL_DATABASE_DB'] = os.environ['DB_NAME']
app.config['MYSQL_DATABASE_HOST'] = os.environ['DB_HOST']
app.config['MYSQL_DATABASE_PORT'] = int(os.environ['DB_PORT'])


mysql.init_app(app)

        
# set a secret key for the session
# import secrets
# secret_key = secrets.token_hex(16)
app.secret_key = '8a2c07687244ceade6915b407aa6da4c'

sql_executed = False
def execute_sql():
    global sql_executed
    if not sql_executed:
        try:
            sql_file = 'BucketList.sql'
            command = [
                'mysql',
                '-u', app.config['MYSQL_DATABASE_USER'],
                '-p' + app.config['MYSQL_DATABASE_PASSWORD'],
                '-h', app.config['MYSQL_DATABASE_HOST'],
                '-P', str(app.config['MYSQL_DATABASE_PORT']),
                app.config['MYSQL_DATABASE_DB'],
                '<', sql_file
            ]
            subprocess.run(command, shell=True, check=True)
            sql_executed = True
        except subprocess.CalledProcessError as e:
            return "An error occurred: " + str(e)


@app.route("/")
def main():
    execute_sql()
    return render_template('index.html')
### Here For Readness and Liveness Deployment

@app.route('/healthz')
def health_check():
    return "OK", 200


@app.route('/ready')
def readiness_check():
    return "OK", 200

@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')


@app.route('/signUp', methods=['POST'])
def signUp():
    # read the posted values from the UI
    _name = request.form['inputName']
    _email = request.form['inputEmail']
    _password = request.form['inputPassword']

    # validate the received values
    if _name and _email and _password:
        conn = mysql.connect()
        cursor = conn.cursor()

        cursor.callproc('sp_createUser', (_name, _email, _password))

        data = cursor.fetchall()

        if len(data) == 0:
            conn.commit()
            return render_template('check.html', error='User created successfully!')
        else:
            return render_template('check.html', error='Email already exists!')
    else:
        return render_template('check.html', error='Enter the required fields')


@app.route('/showSignIn')
def showSignin():
    return render_template('signin.html')


@app.route('/validateLogin', methods=['POST'])
def validateLogin():
    try:
        _username = request.form['inputEmail']
        _password = request.form['inputPassword']
        print(_username)
        con = mysql.connect()
        cursor = con.cursor()
        cursor.callproc('sp_validateLogin', (_username,))
        data = cursor.fetchall()
        cursor.close()
        con.close()
        if len(data) > 0:
            if data[0][3] == _password:
                session['user'] = data[0][0]
                return redirect('/userHome')
            else:
                return render_template('error.html', error='Invalid email or password')
        else:
            return render_template('error.html', error='User does not exist')

    except Exception as e:
        return render_template('error.html', error=f'An error occurred: {e}')



@app.route('/userHome')
def userHome():
    if session.get('user'):
        return render_template('userHome.html')
    else:
        return render_template('error.html', error='Unauthorized Access')


@app.route('/logout')
def logout():
    session.pop('user', None)
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

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_addWish', (_title, _description, _user))
            data = cursor.fetchall()
            cursor.close()
            conn.close()
            if len(data) == 0:
                conn.commit()
                return redirect('/userHome')
            else:
                return render_template('error.html', error='An error occurred!')

        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getWish')
def getWish():
    try:
        if session.get('user'):
            _user = session.get('user')

            con = mysql.connect()
            cursor = con.cursor()
            cursor.callproc('sp_GetWishByUser', (_user,))
            wishes = cursor.fetchall()

            wishes_dict = []
            for wish in wishes:
                wish_dict = {
                    'Id': wish[0],
                    'Title': wish[1],
                    'Description': wish[2],
                    'Date': wish[4]}
                wishes_dict.append(wish_dict)

            return json.dumps(wishes_dict)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002, debug=True)
