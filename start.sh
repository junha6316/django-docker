#!/bin/sh 
yes | python manage.py makemigrations --settings=config.deploy.settings
echo "==> Django setup, executing: migrate pro"
python manage.py migrate --settings=config.deploy.settings --fake-initial
echo "==> Django setup, executing: collectstatic"
python manage.py collectstatic --settings=config.deploy.settings --noinput -v 3
pip install -r /code/requirements.txt
echo "==> Django deploy"
gunicorn -b 0.0.0.0:8000 --env DJANGO_SETTINGS_MODULE=config.deploy.settings config.wsgi:application & daphne -b 0.0.0.0 -p 8009 config.asgi:application
