

FROM flyway/flyway

WORKDIR /flyway

RUN mkdir -p /flyway/db/migrations

COPY ./db/migrations /flyway/db/migrations
