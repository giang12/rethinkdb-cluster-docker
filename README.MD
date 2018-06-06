# Docker Kafka Cluster

[![docker pulls](https://img.shields.io/docker/pulls/zen12/rethinkdb-cluster.svg)](https://hub.docker.com/r/zen12/rethinkdb-cluster/)
[![docker stars](https://img.shields.io/docker/stars/zen12/rethinkdb-cluster.svg)](https://hub.docker.com/r/zen12/rethinkdb-cluster/)

Creates a [Docker](https://www.docker.com)-based [RethinkDB](https://www.rethinkdb.com/)
cluster with [docker swarm](https://docs.docker.com/get-started/part5/).

# Get started

1. Make it run
```
docker stack deploy rethinkdb-cluster -c docker-compose.yml
```
2. Go into the rethink ui (http://localhost:8081), add a database called `clustertest` and a table called `importantData`. Add a document containing anything into this table.
```
r.dbCreate('clustertest').tableCreate('importantData')
r.db('clustertest').table('importantData').insert({"ayyy":"lmao"})
```
Now you can start terrorizing the system.

Kill a rethink server:

    docker service stop rethinkdb-cluster_rethinkdb2

You can kill two servers and the test app should continue working nicely. The app complains about not being able to access all servers in the cluster, but all DB operations are operational.

If you kill three servers you have less than half a cluster, so it will go offline.

Restart a rethink server:

    docker service start rethinkdb-cluster_rethinkdb2

No matter how many of the server containers are down, they will all start and join the cluster.

# Default Ports

  - 29015-29019 #Listening for intracluster connections
  - 28015-28019 #Listening for client driver connections
  - 8081-8085	#Listening for administrative HTTP connections
