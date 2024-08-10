# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Update the package lists

RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install wget -y

RUN apt-get install  software-properties-common -y


# Install Apache2
RUN apt-get install  apache2 -y

# Install PHP 7.4 and required extensions

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath



#Install SSH Server
RUN apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 admin
RUN echo 'admin:tik' | chpasswd
RUN service ssh start

RUN apt-get install nano
RUN apt-get install git -y



# Configure Apache2 to use PHP 7.4
RUN a2enmod rewrite && \
    a2enmod php7.4 && \
    service apache2 restart

WORKDIR /tmp
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" ;
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"


RUN mv composer.phar /usr/local/bin/composer 
# Verify Composer installation
RUN composer --version

# Set the default Apache document root
WORKDIR /var/www/html

# Expose port 80 for Apache


#RUN /etc/init.d/apache2 start


WORKDIR /app
RUN curl -fsSL https://code-server.dev/install.sh | sh


#install couchdb


# Start Apache and SSH
EXPOSE 80 22 8080
CMD ["bash", "-c", "apachectl -D FOREGROUND & /usr/sbin/sshd -D & code-server --bind-addr 0.0.0.0:8080"]