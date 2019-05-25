FROM python:3

COPY . /app

ADD VERSION .

RUN pip install --upgrade pip
RUN pip install watchdog

CMD [ "python3", "/app/makefile_completer.py" ]
