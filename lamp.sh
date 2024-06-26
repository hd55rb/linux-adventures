#!/bin/bash

clear

echo "Choose LAMP or LEMP stack"
echo "1. LAMP - Apache,MySQL,PHP)"
echo "2. LEMP - NginX, MySQL, PHP)"

read -p "Enter your choice (1/2): " choice

if [ "$choice" = "1" ]; then
  echo "Installing LAMP stack..."
  # Install LAMP stack here
  sudo apt update && sudo apt upgrade -y
  apt install apache2 -y & wait
  sudo ufw allow http -y
  echo "Installing MySQL"

  sudo apt install mysql-server -y & wait

  echo "Setting MySQL root password..."

  read -p "Enter a new password for the root user: " ROOT_PASSWORD
  read -p "Confirm the password: " CONFIRM_PASSWORD
# IF statement for setting pw
  if [ "$ROOT_PASSWORD" = "$CONFIRM_PASSWORD" ]; then
    sudo mysql_secure_installation <<EOF
y
$ROOT_PASSWORD
$ROOT_PASSWORD
0
y
y
y
EOF
echo "MySQL Installed and configured !"
 else
    echo "Passwords do not match. Please try again."
  fi
# Closing the IF statement

sudo mysql
...
exit

echo "Installing PHP"

sudo apt install php libapache2-mod-php php-mysql -y & wait

sudo sed -i 's/index.html index.cgi index.pl index.php index.xhtml index.htm/index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-available/dir.conf
sudo a2enmod dir -y
sudo systemctl restart apache2

sudo apt install php-cli -y & wait

#Creating Virutal Host
echo "Creating Virtual Host"

sudo mkdir /var/www/hristiyan
sudo chown -R $USER:$USER /var/www/hristiyan
sudo nano /etc/apache2/sites-available/hristiyan.conf

DOMAIN="hristiyan"
DOCUMENT_ROOT="/var/www/$DOMAIN"

echo "<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    ServerAdmin webmaster@localhost
    DocumentRoot $DOCUMENT_ROOT
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>" | sudo tee /etc/apache2/sites-available/$DOMAIN.conf
 #tva e da suzdam file i da go otvorq s nano, a s | (prava cherta)  da pisha direktno v nego
#Save and Close - sudo nano -w
sudo nano -w /etc/apache2/sites-available/$DOMAIN.conf

sudo a2ensite hristiyan
  fi
# Closing the IF statement

sudo mysql
...
exit

echo "Installing PHP"

sudo apt install php libapache2-mod-php php-mysql -y & wait

sudo sed -i 's/index.html index.cgi index.pl index.php index.xhtml index.htm/index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-available/dir.conf
sudo a2enmod dir -y
sudo systemctl restart apache2

sudo apt install php-cli -y & wait

#Creating Virutal Host
echo "Creating Virtual Host"

sudo mkdir /var/www/hristiyan
sudo chown -R $USER:$USER /var/www/hristiyan
sudo nano /etc/apache2/sites-available/hristiyan.conf

DOMAIN="hristiyan"
DOCUMENT_ROOT="/var/www/$DOMAIN"

echo "<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    ServerAdmin webmaster@localhost
    DocumentRoot $DOCUMENT_ROOT
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>" | sudo tee /etc/apache2/sites-available/$DOMAIN.conf
 #tva e da suzdam file i da go otvorq s nano, a s |(prava cherta) da pisha direktno v nego
#Save and Close - sudo nano -w
sudo nano -w /etc/apache2/sites-available/$DOMAIN.conf

sudo a2ensite hristiyan
sudo a2dissite 000-default
sudo systemctl reload apache2

#Checking if things are working
nano /var/www/hristiyan/index.html
echo "<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello, LAMP Installed</h1>

    <p>This is the landing page of <strong>Hristiyan</strong>.</p>

elif [ "$choice" = "2" ]; then
  echo "Installing LEMP stack..."
  # Install LEMP stack here
sudo apt update && sudo apt upgrade  -y
sudo apt install nginx -y & wait
sudo ufo allow ‘Nginx Full’

echo “Installing MySQL”

sudo apt install mysql-server -y & wait

echo “Setting MySQL root password…”  

read -p "Enter a new password for the root user: " ROOT_PASSWORD
  read -p "Confirm the password: " CONFIRM_PASSWORD
# IF statement for setting pw
  if [ "$ROOT_PASSWORD" = "$CONFIRM_PASSWORD" ]; then
    sudo mysql_secure_installation <<EOF
y
$ROOT_PASSWORD
$ROOT_PASSWORD
0
y
y
y
EOF
echo "MySQL Installed and configured !"
 else
    echo "Passwords do not match. Please try again."
  fi
# Closing the IF statement

sudo mysql
...
exit

echo "Installing PHP"

sudo apt install php-fpm php-mysql -y & wait

#neshta koito copy-paste bez da razbiram

sudo sed -i 's/index.nginx-debian.html/index.php index.nginx-debian.html/' /etc/nginx/sites-available/default
sudo sed -i 's/#location ~ \\.php\$ {/location ~ \\.php\$ {/' /etc/nginx/sites-available/default
sudo sed -i 's/#\tinclude snippets\/fastcgi-php.conf;/\tinclude snippets\/fastcgi-php.conf;/' /etc/nginx/sites-available/default
sudo sed -i 's/#\tfastcgi_pass unix:\/run\/php\/php7.4-fpm.sock;/\tfastcgi_pass unix:\/run\/php\/php7.4-fpm.sock;/' /etc/nginx/sites-available/default
sudo sed -i 's/#}/}/' /etc/nginx/sites-available/default

sudo systemctl restart nginx

echo “Creating Virtual Host”

sudo mkdir /var/www/hristiyan
sudo chown -R $USER:USER /var/www/hristiyan
DOMAIN=“hristiyan”
DOCUMENT_ROOT=“/var/www/$DOMAIN”

echo “server {
	listen 80;
	server name $DOMAIN www.$DOMAIN;

	root $DOCUMENT_ROOT;
	index index.php index.html index.htm

	location / {
		try_files \$uri \$uri/ =404;
	}

	location ~ \\.php\$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/run/php/php7.4-fpm.sock;
	}

	location ~ /\\.ht {
		deny all;
	}
	error_log /var/log/nginx/$DOMAIN.error.log;
	access_log /var/log/nginx/$DOMAIN.access.log;
}" | sudo tee /etc/nginx/sites-available/$DOMAIN

sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/

sudo systemctl restart nginx

#Checking if things are working
nano /var/www/hristiyan/index.html
echo "<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello, LAMP Installed</h1>

    <p>This is the landing page of <strong>Hristiyan</strong>.</p>

else
  echo "Invalid choice. Please try again."
fi


