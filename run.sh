#!/bin/sh

CONFIG_FILE="/opt/ibm/app/relay.toml"

# update config env variables if template exists
if [ -f ${CONFIG_FILE}.tpl ]; then
    envtpl ${CONFIG_FILE}.tpl
    if [ $? -ne 0 ]; then
        echo "ERROR - unable to generate $CONFIG_FILE"
        exit 1
    fi
else
    echo "INFO - no ${CONFIG_FILE}.tpl found, will look for ${CONFIG_FILE}..."
fi

# ensure a config file exists
if [ ! -f "${CONFIG_FILE}" ]; then
    echo "ERROR - can't find ${CONFIG_FILE}"
    exit 1
fi

CMD="/bin/influxdb-relay"
CMDARGS="-config=${CONFIG_FILE}"
exec "$CMD" $CMDARGS
