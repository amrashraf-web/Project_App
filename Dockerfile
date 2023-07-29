# Use the official Python image as the base image
FROM python:3.9


# Set the working directory to /app
WORKDIR /app

# Copy the Flask app files from the host into the container at /app
COPY MySQL-and-Python/FlaskApp /app
COPY MySQL-and-Python/MySQL_Queries /app

# Install the required dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the Flask app port (change the port if needed)
EXPOSE 5000

# Command to run the app

CMD ["python", "app.py"]
