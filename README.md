## Goal
To use [MoSQL](https://github.com/stripe/mosql) to replicate MongoDB documents into a PostgreSQL RDBMS.

### Success Criteria
1. row by row replication of MongoDB documents into PostgreSQL
2. All fields not defined in the PostgreSQL schema should either be discarded or serialized and persisted.
3. All failed writes should gracefully return an error that is catchable

### Assumptions
* You have MongoDB installed
* You have PostgreSQL installed
* Both databases are available on `localhost`
* MongoDB is being populated by a Meteor application

## Implementation
* Install MoSQL -> `$ gem install mosql`
    * You may have to install `libpq-dev` also -> `$ sudod apt-get install libpq-dev`

## Resources
* [MoSQL Readme](https://github.com/stripe/mosql/blob/master/README.md)

