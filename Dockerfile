FROM python:3

COPY makefile_completer.py /app/makefile_completer.py

# TODO Upgrade pip each time
RUN pip install watchdog

CMD [ "python3", "/app/makefile_completer.py" ]
