#!/usr/bin/env python3
from flask import Flask, render_template
import requests

app = Flask(__name__)

def get_instance_data():
    hostname = requests.get("http://169.254.169.254/latest/meta-data/hostname").text
    instance_id = requests.get("http://169.254.169.254/latest/meta-data/instance-id").text
    instance_type = requests.get("http://169.254.169.254/latest/meta-data/instance-type").text
    public_ipv4 = requests.get("http://169.254.169.254/latest/meta-data/public-ipv4").text
    return hostname, instance_id, instance_type, public_ipv4

    

@app.route('/')
def index():
    aws_data = get_instance_data()
    return render_template('index.html', 
            hostname=aws_data[0], 
            instance_id=aws_data[1],
            instance_type=aws_data[2],
            public_ipv4=aws_data[3])


