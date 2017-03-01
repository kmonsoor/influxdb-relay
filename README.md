# Influxdb-relay
A wrapper repository to build and configure influxdb's HA relay implementation:
https://github.com/influxdata/influxdb-relay

## Build and Run the container

Run the following command within the cloned repo to build the docker image:
```
docker build . -t influxdb-relay
```

Example command to run the built relay image:
```
docker run -d -i -t \
-e HTTP_BACKEND_influxdb_1=influxdb1:8086 \
-e HTTP_BACKEND_influxdb_2=influxdb2:8086 \
influxdb-relay
```

## Configuration

Variable | Description | Default value | Sample value 
-------- | ----------- | ------------- | ------------
HTTP_BIND_ADDR | bind address for the HTTP listener | :9096 |
HTTP_BACKEND_xx | host:port of an influxDB backend, http protocol | | influxdbx:8086
