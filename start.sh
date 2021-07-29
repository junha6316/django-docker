#!/bin/sh 
yes | python manage.py makemigrations --settings=test_page.settings
echo "==> Django setup, executing: migrate pro"
python manage.py migrate --settings=test_page.settings --fake-initial
echo "==> Django setup, executing: collectstatic"
python manage.py collectstatic --settings=test_page.settings --noinput -v 3
pip install -r /code/requirements.txt
echo "==> Django deploy"
gunicorn -b 0.0.0.0:8000 --env DJANGO_SETTINGS_MODULE=test_page.settings test_page.wsgi:application
