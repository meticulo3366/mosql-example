## Goal
To use [MoSQL](https://github.com/stripe/mosql) to replicate MongoDB documents into a PostgreSQL RDBMS.

### Success Criteria
1. row by row replication of MongoDB documents into PostgreSQL
2. All fields not defined in the PostgreSQL schema should either be discarded or serialized and persisted.
3. All failed writes should gracefully return an error that is catchable

### Assumptions
* You have MongoDB installed
* You have PostgreSQL installed, and your user has a role defined
* Both databases are available on `localhost`
* MongoDB is being populated by a Meteor application

## Implementation
* Install MoSQL -> `$ gem install mosql`
    * You may have to install `libpq-dev` also -> `$ sudod apt-get install libpq-dev`
* Create demo meteor app -> `$ mrt create example`
* Setup Collections ( see `init_browsers.coffee` for an example how )
* Create `collections.yml`
* Setup MongoDB for replication
    * `$ mongod --replSet meteor`
    * `$ mongo`
        * `> var config = {_id: "meteor", members: [{_id: 0, host: "127.0.0.1:127017"}]}`
        * `> rs.initiate(config)`
* startup meteor running on local mongodb
    * `$ PORT=3000 MONGO_URL=mongodb://localhost:27017/meteor meteor`
* start `mosql` replicator
    * `$ mosql`

`mosql` output should look something like this :
```shell
 INFO MoSQL: Creating table 'pages'...
 INFO MoSQL: Creating table 'browsers'...
 INFO Mongoriver: Starting oplog stream from seconds: 1395855130, increment: 0
 INFO Mongoriver: Saved timestamp: seconds: 1395855130, increment: 1 (2014-03-26 10:32:10 -0700)
 INFO Mongoriver: Saved timestamp: seconds: 1395855611, increment: 1 (2014-03-26 10:40:11 -0700)
 INFO Mongoriver: Saved timestamp: seconds: 1395855786, increment: 1 (2014-03-26 10:43:06 -0700)
 INFO Mongoriver: Saved timestamp: seconds: 1395855861, increment: 1 (2014-03-26 10:44:21 -0700)
```

## Summary
MongoDB is now writable from meteor and replicating to PostgreSQL.

This can be verified by inserting mongo docs from the meteor app, and querying for them in postgres.

## Resources
* [MoSQL Readme](https://github.com/stripe/mosql/blob/master/README.md)

