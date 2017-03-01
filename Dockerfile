FROM alpine:3.4

#add python and envtpl (used for relay templating) to the alpine container
RUN apk update && apk upgrade && \
    apk --no-cache add python ca-certificates curl wget bash && \
    apk --virtual envtpl-deps add --update py-pip python-dev && \
    curl https://bootstrap.pypa.io/ez_setup.py | python && \
    pip install envtpl && \
    apk del envtpl-deps && rm -rf /var/cache/apk/* /setuptools-*.zip
    
#add the build depenedencies and build the influxdb-relay image    
RUN apk update && apk upgrade && \
    apk --virtual build-deps add go>1.6 curl git gcc musl-dev make && \
    export GOPATH=/go && \
    go get -v github.com/influxdata/influxdb-relay && \
    cd $GOPATH/src/github.com/influxdata/influxdb-relay && \
    python ./build.py && \
    chmod +x ./build/influx* && \
    ls -l ./build/* && \
    mv ./build/influx* /bin/ && \
    apk del build-deps && cd / && rm -rf $GOPATH/ /var/cache/apk/*

EXPOSE 9096

#copy the config template and the start-up script to the container
WORKDIR /opt/ibm/app
COPY relay.toml.tpl .
COPY run.sh .

CMD ["bash", "run.sh"]
