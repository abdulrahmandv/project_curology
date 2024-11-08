#!/bin/bash
# Update and install required packages

dnf update -y
dnf install mariadb105-server -y 
yum install -y python3 pip ncurses-compat-libs

DD_API_KEY=${{ secrets.DD_API_KEY }} DD_SITE="us5.datadoghq.com" bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Install pip and Flask
pip3 install flask mysql-connector-python pymysql

# Set environment variables for database connection
export DB_HOST="my-database.cg5rarw5igck.us-east-1.rds.amazonaws.com"
export DB_USER="admin"
export DB_PASS="securepassword"
export DB_NAME="hello_world_db"
export DB_PORT="3306"

mysql -h $DB_HOST -u $DB_USER -P $DB_PORT -p$DB_PASS -D $DB_NAME <<EOF
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);
INSERT INTO messages (message) VALUES ("Hello World");
EOF

# Download the Flask app
cat << 'EOPYTHON' > /home/ec2-user/app.py
from flask import Flask
import pymysql

app = Flask(__name__)

def get_db_connection():
    return pymysql.connect(
        host="my-database.cg5rarw5igck.us-east-1.rds.amazonaws.com",
        user="admin",
        password="securepassword",
        database="helloworld"
    )

@app.route('/')
def hello_world():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT content FROM messages LIMIT 1;")
    result = cursor.fetchone()
    connection.close()
    return f"<html><body><h1>{result[0]}</h1></body></html>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
EOPYTHON



# Run the Flask application
chmod 755 /home/ec2-user/app.py
nohup python3 /home/ec2-user/app.py &
