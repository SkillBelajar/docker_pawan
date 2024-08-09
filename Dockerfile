# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Update the package lists
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y software-properties-common


# Install Apache2
RUN apt-get install -y apache2

# Install PHP 7.4 and required extensions
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath


#Install SSH Server

# Set the default Apache document root
WORKDIR /var/www/html

# Expose port 80 for Apache
EXPOSE 80

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]
