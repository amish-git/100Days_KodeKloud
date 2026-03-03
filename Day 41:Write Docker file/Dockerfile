# Ubuntu 24.04 as base image
FROM ubuntu:24.04

# Install apache2
RUN apt-get update && apt-get install -y apache2 && apt-get clean

# Change the listening port from 80 to 6100
RUN sed -i 's/80/6100/g' /etc/apache2/ports.conf && \
    sed -i 's/*:80/*:6100>/g' /etc/apache2/sites-available/000-default.conf

# Expose port
EXPOSE 6000

# Start apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]