#!/bin/bash

echo "==================="
echo "==================="
echo "==================="
echo "This script sets up the AWS Ubuntu image with Apache and a Django project"
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
sudo export AWS_ACCESS_KEY_ID=ASIAWCEO7EA6ZYT5EXKE
sudo export AWS_SECRET_ACCESS_KEY=EtR4t8zTVSGe30q9zfBB8zyomT4FtaNxB/USxc6I
IQoJb3JpZ2luX2VjEAEaCXVzLWVhc3QtMSJGMEQCIHoLPUBp6/PqJtqtNQmpQLs1nTiD6wV67GsjpYWO/ZCcAiAkTXVsPMjzMjnAkbMTuxxQrmmnVLTegcTwCHqRhFQnwyqBAwia//////////8BEAAaDDQxNjkxMTY2MzE2NSIMWjgfu0T+gq2JzpnVKtUC0H7YZ2BR8Y9ILimOHagflZNWVgdRgJocvdJuWnL988OXWGibnsAc8kTQ5/buC6B/SqLBcEXsYtzRxm+DSLTKIz+9Uakdmajs4cJz660YkLVv1Web6mK72JsQY9+8pwB7s0v6sLJ67kS/v43aQ8YFN5X8+w5WhkQrg9W389QbemkNQnAGTgZGiqFVJmkIhCd4fdO7Y74tQNbjveLuaXOgwUxaGhgI0tfw7F4fsbJzay4+2RVU+7lNiCoqYm6SSU4k3fqNKbYhu9+OC0zgveh0iy/P69oYObi1B9wow0vA6dnhW3iAhd7NHdanGF94uSHcvwfyqHGi/iT9qOTs5j9gTv2m+X6fhmhx/FlKjI/feObbmQhmDHHwFsW1I/0qT7nv0bMFSNnUfl18jXZi3xVG9VwthfstpZblQGOZd/iughCUATPEuSP3OveTlxFKY+98rKSaU0Aw36qE+AU61QLva44zNqT6kaOi2Vndu70X85jIMlCftV2m5hbsYA1ECEvhXs4CiiieXF0hQzzHmtOvt0xdREqp9o++aBAGn0lQOHZZnl2J42o8lEgRgvA0KWCQrIvzkhYcmNvk7/KMGXH/fzuY4ikDItgJ3BCC7vtNw1wxTwArtqNBtvNXm4W0ncGlMMh3ooaxGKxO5WqcxpV4fhnUSgRhJFkXIyXBcHnMI1GIJ3d7bCdfuURr9dj7e7pX/qw4dc+iJnmp4nceG3isOKrC5zcc3lQ5+69Qf5YvYntwQIsphERHPQDK7EMC7zrGISVH0iN59Jlv/XfxnEkao8A3TpXEwhK5BAlfWyKBv7fg1dEu4z3uM9lOFdx59QhBDxgsBooebclmTEB9uOEEDhI3m8lVlHsVZqHUVU78CYz487wG4TcZmNZ+ngLlkxv7/pc+uWE/RS1Cb6Wj7jn6CaqqFA==
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

# git clone Django Animal Chat


if [ ! -f /home/ubuntu/django_project/venv ]; then
	# create a virtual env in the 'django_project' directory
	python3 -m venv /home/ubuntu/django_project/venv
fi

# enable the virtual env
source /home/ubuntu/django_project/venv/bin/activate

if [ -f /home/ubuntu/django_project/requirements.txt ]; then
	# install packages --> requirements.txt
	pip3 install -r requirements.txt
else
	# install package --> django==2.1.1
	pip3 install django==2.1.1
fi

# create a django project
# the . puts the manage.py in the current directory
django-admin  startproject alpha /home/ubuntu/django_project
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
echo "Go into 'alpha/settings.py' and add this line at the bottom"
echo "    STATIC_ROOT = os.path.join(BASE_DIR, \"static/\")"
echo "Add AWS IPv4 Public IP to ALLOWED HOSTS in 'alpha/settings.py'"
echo "    Example: ALLOWED_HOSTS = ['54.158.154.186',]"
echo "Execute 'sudo service apache2 restart' when finished and it is good to go!"
echo "==================="
echo "==================="
echo "==================="
