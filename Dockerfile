# Use the official Ubuntu 20.04 image as the base
FROM ubuntu:20.04

# Update the package lists and install necessary packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath && \
    apt-get install -y nano git && \
    apt-get install -y openssh-server sudo && \
    useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1001 test && \
    passwd -d test && \
    service ssh start

# Set the default Apache document root
WORKDIR /var/www/html/public

# Expose port 80 for Apache
EXPOSE 80

# Start Apache and SSH
CMD ["apachectl", "-D", "FOREGROUND", "&&", "/usr/sbin/sshd", "-D"]
