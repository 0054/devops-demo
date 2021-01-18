FROM python:3.7

WORKDIR /app

COPY . /app

RUN pip3 install -r /app/requirements.txt

expose 80

CMD ["./runapp.sh"]
