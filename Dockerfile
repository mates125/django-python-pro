# TODO: Change to an officially released version of Python before deploying to production.
ARG PYTHON_VERSION=3.12-slim

FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /code

WORKDIR /code

RUN pip install pipenv
COPY Pipfile Pipfile.lock /code/
RUN pipenv install --deploy --system
COPY . /code

EXPOSE 8000

CMD ["gunicorn","--bind",":8000","--workers","2","pypro.wsgi"]
