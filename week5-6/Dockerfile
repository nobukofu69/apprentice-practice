FROM mysql:8.0

# Set environment variables
ENV MYSQL_DATABASE=mydb
ENV MYSQL_USER=docker
ENV MYSQL_PASSWORD=docker
ENV MYSQL_ROOT_PASSWORD=root

# Set the timezone
ENV TZ=UTC

# Add custom configuration
RUN echo "[mysqld]\ncharacter-set-server=utf8mb4\n\n[client]\ndefault-character-set=utf8mb4" > /etc/mysql/conf.d/custom.cnf

# Expose port 3306
EXPOSE 3306
