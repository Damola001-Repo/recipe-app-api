FROM python:3.9-alpine3.13
LABEL maintainer="damolathedev"

ENV PYTHONUNBUFFERED=1

# Install system dependencies needed for venv + building common Python packages
RUN apk add --no-cache \
    python3-dev \
    build-base \
    libffi-dev \
    musl-dev \
    postgresql-dev \
    zlib-dev \
    jpeg-dev \
    bash \
    && python -m ensurepip \
    && pip install --no-cache --upgrade pip setuptools wheel

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "${DEV}" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt ; fi && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user
