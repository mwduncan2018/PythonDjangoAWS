# DjangoChat

### Setup Steps
##### On AWS, launch an instance of Ubuntu 18
##### Clone this repository at /home/ubuntu
##### As root, run /home/ubuntu/django_project/ubuntu-apache-django-setup.sh
##### Add the AWS IPv4 Public IP to ALLOWED_HOSTS located in /home/ubuntu/django_project/alpha/settings.py
##### Add the boto3credentials.ini at /home/ubuntu
##### execute "sudo service apache2 restart" and the website is running on Apache
