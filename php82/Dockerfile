# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Update the package lists
RUN apt-get update && apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install wget -y

RUN apt-get install  software-properties-common -y

# Install Apache2
RUN apt-get install  apache2 -y

# Install PHP 8.2 and required extensions
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y php8.2 php8.2-cli php8.2-common php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath

# Install SSH Server
RUN apt install  openssh-server sudo -y
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 admin
RUN echo 'admin:tik' | chpasswd
RUN service ssh start

RUN apt-get install nano
RUN apt-get install git -y

# Configure Apache2 to use PHP 8.2
RUN a2enmod rewrite && \
    a2enmod php8.2 && \
    service apache2 restart

WORKDIR /tmp
RUN wget https://raw.githubusercontent.com/SkillBelajar/docker_pawan/main/etc/composer-setup.php
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

#setting agar bisa url laravel
WORKDIR /etc/apache2
RUN rm apache2.conf
RUN wget https://raw.githubusercontent.com/SkillBelajar/docker_pawan/main/etc/apache2.conf

WORKDIR /var/www/html

# Start Apache and SSH
EXPOSE 80 22 8080
CMD ["bash", "-c", "apachectl -D FOREGROUND & /usr/sbin/sshd -D & code-server --bind-addr 0.0.0.0:8080"]
