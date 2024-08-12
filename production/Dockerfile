# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Update the package lists

RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install apache2 -y
RUN apt-get install wget -y
RUN apt-get install nano -y
WORKDIR /var/www/html
#RUN echo "CONTOH=${CONTOH}" >> .env
ARG ENV_FILE=https://raw.githubusercontent.com/SkillBelajar/docker_pawan/main/etc/.env
RUN wget $ENV_FILE


# Expose port 80 for Apache

#install couchdb


# Start Apache and SSH
EXPOSE 80
CMD ["bash", "-c", "apachectl -D FOREGROUND"]