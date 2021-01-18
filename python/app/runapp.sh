#!/bin/bash -x

gunicorn --bind 0.0.0.0:8000 app:app -w 2 --threads 2 
