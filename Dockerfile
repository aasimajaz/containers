FROM registry.access.redhat.com/ubi8:8.7-929
LABEL author "Aasim Ajaz"
RUN dnf install -y httpd procps-ng 
COPY index.html /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd","-D","FOREGROUND"]
