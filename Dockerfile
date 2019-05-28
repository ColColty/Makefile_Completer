FROM python:3

COPY . /home

RUN pip install --upgrade pip
RUN pip install watchdog==0.9.0

WORKDIR /home

CMD [ "python3", "makefile_completer.py" ]
