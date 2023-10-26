
#WEBAPP-DB   
---------------------------------------------------------------------------------------------

### Summary
---------------------------------------------------------------------------------------------
This project focuses on setting up a database for the application, creating a schema, and ensuring zero-downtime database migrations using Flyway. 

-----------------------
**Prerequisite:** 
Following prerequisites to be installed:
- PostgreSQL 
- Flyway 
- Docker 

**Database Setup**

1. Create a New Database- The application requires a database named `app` 

2. Create a Schema - In PostgreSQL, a schema named `app` will be created for the application. All database objects will be contained within this schema to avoid conflicts with the public schema

**Database Migrations**

Database migration is done using Flyway to ensure zero-downtime database migrations. All migration scripts are written in SQL to create, alter, or drop database objects such as tables, views, indexes, etc.

1. Create a Flyway Container
    - Build a Docker image for Flyway to run migrations.
    ```
    docker build -t flyway .
    ```
2. Run the Migrations
    - Apply the migrations and configure database:
    ```
    docker run --rm --name flyway -e FLYWAY_URL=${FLYWAY_URL} flyway 
    ```
3. Verify Migrations
    - Check the status and version of your migrations using Flyway:
    ```
    docker run --rm --name flyway -e FLYWAY_URL=${FLYWAY_URL} flyway info
    ```
   Output to STDOUT
    - Flyway provides detailed output about the migration process, which is written to the standard output (STDOUT). This provides a clear overview of the migration's progress and status.


 
_This project is part of CSYE7125 course_

