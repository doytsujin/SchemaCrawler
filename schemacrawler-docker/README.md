# Docker Image for SchemaCrawler

> Please see the [SchemaCrawler website](http://www.schemacrawler.com/).

## Download

The pre-packaged [Docker image for SchemaCrawler](https://hub.docker.com/r/schemacrawler/schemacrawler/) is on Docker Hub.


## Run

Download the latest Docker image for SchemaCrawler from Docker Hub, run
```
docker pull schemacrawler/schemacrawler
```

Check that the Docker image for SchemaCrawler has been installed correctly, run
```
docker run \
-v $(pwd):/share \
--rm -i -t \
--entrypoint=/bin/bash \
schemacrawler/schemacrawler
```

Then, run SchemaCrawler from the command-line within the container, like this
```
./schemacrawler.sh \
-server=sqlite -user= -password= -database=sc.db \
-infolevel=maximum -routines= -command=schema \
-outputfile=/share/sc_db.png
```
The image exports a volume called `/share`, and you can map it to your local directory. 

Exit the Docker container for SchemaCrawler, and look at the `sc_db.png` file in your local directory.

## Examples

### Run SchemaCrawler Against Microsoft SQL Server on Amazon RDS

Here is an example of how to connect to Microsoft SQL Server on Amazon RDS. Run the SchemaCrawler Docker image using the command above, to get a new container, with a command shell. Then run SchemaCrawler, for example
```
./schemacrawler.sh \
-server=sqlserver -host=host.us-east-1.rds.amazonaws.com \
-user=schemacrawler -password=schemacrawler \
-database=SCHEMACRAWLER -schemas=SCHEMACRAWLER.dbo \
-infolevel=minimum -command=list
```

### Run SchemaCrawler Against PostgreSQL Running in Another Docker Container

Follow instructions on [Docker Hub for running a PostgreSQL container](https://hub.docker.com/_/postgres/).

Run your PostgreSQL Docker container, making sure to specify a host name with the `-h` option, for example, run
``` 
docker run --name scpostgres \
-e POSTGRES_USER=schemacrawler \
-e POSTGRES_PASSWORD=schemacrawler \
-h postgres_host \
-d postgres
```

Create your schema with `psql`, like this
```
docker run -it --rm --link scpostgres:postgres postgres \
psql -h postgres -U schemacrawler
```

Run the Docker image for SchemaCrawler against your PostgreSQL database, for example
```
docker run \
--link scpostgres:postgres \
-v $(pwd):/share \
--rm -i -t \
--entrypoint=/bin/bash \
schemacrawler/schemacrawler
```

Then, run SchemaCrawler from the command-line within the container, like this
```
./schemacrawler.sh \
-server=postgresql -host=postgres_host \
-user=schemacrawler -password=schemacrawler \
-database=schemacrawler \
-infolevel=standard -routines= -command=schema \
-outputformat=png \
-o /share/schema.png
```

Exit the Docker container for SchemaCrawler, and look at the `schema.png` file in your local directory.

-----

## Build and Deploy Docker Image

In the directory containing the Docker file, run
```
docker build \
-t schemacrawler/schemacrawler:14.12.01 -t schemacrawler/schemacrawler:latest \
--build-arg SCHEMACRAWLER_VERSION=14.12.01 \
.
```
Of course, change the SchemaCrawler version number.

To deploy, run
```
docker login
docker push schemacrawler/schemacrawler
```
