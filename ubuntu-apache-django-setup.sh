#!/bin/bash

echo "==================="
echo "==================="
echo "==================="
echo "This script sets up an AWS Ubuntu image to use Apache with this Django website"
echo "This script must be executed as root"
echo "==================="
echo "==================="
echo "==================="
echo ""
echo "... PRESS ENTER TO CONTINUE..."
read tempvariable

# update Ubuntu
sudo apt-get update
# install the AWS CLI
sudo apt install awscli -y
# set environment variables to access the AWS CLI
sudo export AWS_ACCESS_KEY_ID=NONE
sudo export AWS_SECRET_ACCESS_KEY=NONE
sudo export AWS_DEFAULT_REGION=us-east-1
# install pip3
sudo apt-get install python3-pip -y
# install python virtual env
sudo apt-get install python3-venv -y
# install apache2
sudo apt-get install apache2 -y
# install libapache2-mod-wsgi-py3
sudo apt-get install libapache2-mod-wsgi-py3 -y

if [ ! -f /home/ubuntu/django_project ]; then
	# make a 'django_project' directory
	mkdir /home/ubuntu/django_project
fi

if [ ! -f /home/ubuntu/django_project/venv ]; then
	# create a virtual env in the 'django_project' directory
	python3 -m venv /home/ubuntu/django_project/venv
fi

# enable the virtual env
source /home/ubuntu/django_project/venv/bin/activate

if [ -f /home/ubuntu/django_project/requirements.txt ]; then
	# install packages --> requirements.txt
	pip3 install -r /home/ubuntu/django_project/requirements.txt
fi

# deactivate the virtual env
deactivate

echo "==================="
echo "==================="
echo "==================="
echo "Part 2 of the setup"
echo "==================="
echo "==================="
echo "==================="
echo ""
echo "... PRESS ENTER TO CONTINUE..."
read tempvariable

# create a virtual host for apache
if [ ! -f /etc/apache2/sites-available/djangoproject.conf ]; then
	touch /etc/apache2/sites-available/djangoproject.conf
	echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "ServerAdmin admin@djangoproject.localhost" >> /etc/apache2/sites-available/djangoproject.conf
	echo "ServerName djangoproject.localhost" >> /etc/apache2/sites-available/djangoproject.conf
	echo "ServerAlias www.djangoproject.localhost" >> /etc/apache2/sites-available/djangoproject.conf
	echo "DocumentRoot /home/ubuntu/django_project" >> /etc/apache2/sites-available/djangoproject.conf
	echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/djangoproject.conf
	echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/djangoproject.conf
	echo "Alias /static /home/ubuntu/django_project/static" >> /etc/apache2/sites-available/djangoproject.conf
	echo "<Directory /home/ubuntu/django_project/static>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "Require all granted" >> /etc/apache2/sites-available/djangoproject.conf
	echo "</Directory>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "Alias /static /home/ubuntu/django_project/media" >> /etc/apache2/sites-available/djangoproject.conf
	echo "<Directory /home/ubuntu/django_project/media>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "Require all granted" >> /etc/apache2/sites-available/djangoproject.conf
	echo "</Directory>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "<Directory /home/ubuntu/django_project/alpha>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "<Files wsgi.py>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "Require all granted" >> /etc/apache2/sites-available/djangoproject.conf
	echo "</Files>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "</Directory>" >> /etc/apache2/sites-available/djangoproject.conf
	echo "WSGIDaemonProcess django_project python-path=/home/ubuntu/django_project python-home=/home/ubuntu/django_project/venv" >> /etc/apache2/sites-available/djangoproject.conf
	echo "WSGIProcessGroup django_project" >> /etc/apache2/sites-available/djangoproject.conf
	echo "WSGIScriptAlias / /home/ubuntu/django_project/alpha/wsgi.py" >> /etc/apache2/sites-available/djangoproject.conf
	echo "</VirtualHost>" >> /etc/apache2/sites-available/djangoproject.conf
fi

# enable the virtual host file
cd /etc/apache2/sites-available
sudo a2ensite djangoproject.conf

# disable the default
sudo a2dissite 000-default.conf

# https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
sudo ufw allow 'Apache'
sudo ufw allow 'Apache Full'
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 22
sudo ufw allow 443
sudo ufw allow 80
sudo ufw enable

# check configuration
sudo apache2ctl configtest

# go to the ubuntu directory
cd /home/ubuntu

echo "==================="
echo "==================="
echo "==================="
echo "Two manual steps must occur before restarting apache"
echo "    1) Add AWS IPv4 Public IP to ALLOWED HOSTS in 'alpha/settings.py'"
echo "           Example: ALLOWED_HOSTS = ['54.158.154.186',]"
echo "    2) Create /home/ubuntu/boto3credentials.ini"
echo "Then, execute 'sudo service apache2 restart' and it is good to go!"
echo "==================="
echo "==================="
echo "==================="
