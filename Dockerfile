# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Update the package lists
RUN apt-get update && apt-get upgrade -y

RUN apt-get install  software-properties-common -y


# Install Apache2
RUN apt-get install  apache2 -y

# Install PHP 7.4 and required extensions

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath


#Install SSH Server
RUN apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 test 
RUN echo 'test:test' | chpasswd
RUN service ssh start

RUN apt-get install nano
RUN apt-get install git -y



# Configure Apache2 to use PHP 7.4
RUN a2enmod rewrite && \
    a2enmod php7.4 && \
    service apache2 restart



# Set the default Apache document root
WORKDIR /var/www/html

# Expose port 80 for Apache
EXPOSE 80 22

RUN /etc/init.d/apache2 start


# Start Apache and SSH
CMD ["bash", "-c", "apachectl -D FOREGROUND & /usr/sbin/sshd -D"]