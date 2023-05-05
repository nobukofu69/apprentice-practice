# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PG_VERSION=13
ENV PG_HBA_CONF=/etc/postgresql/${PG_VERSION}/main/pg_hba.conf
ENV POSTGRES_CONF=/etc/postgresql/${PG_VERSION}/main/postgresql.conf

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y wget lsb-release gnupg2 && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-${PG_VERSION}

# Allow connections from any IP address
RUN echo "host all all 0.0.0.0/0 md5" >> ${PG_HBA_CONF} && \
    echo "listen_addresses='*'" >> ${POSTGRES_CONF}

# Change user to postgres
USER postgres

# Create a new database and user with privileges
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && \
    createdb -O docker docker && \
    /etc/init.d/postgresql stop

# Expose the PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/13/main", "-c", "config_file=/etc/postgresql/13/main/postgresql.conf"]
