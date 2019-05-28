FROM python:3

COPY . /home

RUN pip install --upgrade pip
RUN pip install watchdog

WORKDIR /home

CMD [ "python3", "makefile_completer.py" ]
