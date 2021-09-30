FROM python:3.9

ARG PYTHON_ENV

ENV PYTHON_ENV=${PYTHON_ENV} \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VERSION=1.1.9

RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /var/www/crawler/
COPY poetry.lock pyproject.toml /var/www/crawler/

RUN poetry config virtualenvs.create false \
  && poetry install $(test "$PYTHON_ENV" == production && echo "--no-dev") --no-interaction --no-ansi

COPY . /var/www/crawler/
