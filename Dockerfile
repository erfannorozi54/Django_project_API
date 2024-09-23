FROM python:3.9-alpine3.13
LABEL maintainer="erfan.norozi54@gmail.com"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN mkdir /.virtualenvs && \
    python -m venv /.virtualenvs/dev && \
    /.virtualenvs/dev/bin/python -m pip install --upgrade pip && \
    /.virtualenvs/dev/bin/python -m pip install -r /tmp/requirements.txt && \
    if [ $DEV ="true" ]; \
    then /.virtualenvs/dev/bin/python -m pip install -r /tmp/requirements.dev.txt ;\
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user


ENV PATH="/.virtualenvs/dev/bin:$PATH"

