FROM python:3

COPY makefile_completer /app/makefile_completer

RUN pip install watchdog

CMD [ "python3", "/app/makefile_completer" ]
