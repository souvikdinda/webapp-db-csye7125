FROM flyway/flyway:latest-alpine

COPY ./flyway/sql /flyway/sql

COPY ./flyway/conf /flyway/conf

WORKDIR /flyway

CMD ["migrate"]

