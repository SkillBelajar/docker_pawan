# Use a base image with apt package manager (e.g., Ubuntu)
FROM ubuntu:latest

# Update package lists
RUN apt-get update

# Install wget
RUN apt-get install -y wget

WORKDIR /home
RUN wget https://raw.githubusercontent.com/SkillBelajar/docker_pawan/main/etc/.env

# Clean up apt cache
RUN apt-get clean
