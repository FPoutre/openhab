#!/bin/sh

# Stop and remove all openhab containers (if any)
docker stop $(docker ps -a --format '{{.Names}}' | grep openhab)
docker rm $(docker ps -a --format '{{.Names}}' | grep openhab)

# Run our openhab container. Usage of "latest" insures container to be always up-to-date
docker run \
        --name openhab \
        --net=host \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/timezone:/etc/timezone:ro \
        -v /opt/openhab/conf:/openhab/conf \
        -v /opt/openhab/userdata:/openhab/userdata \
        -v /opt/openhab/addons:/openhab/addons \
	--device /dev/ttyACM0 \
        -d \
        -e USER_ID=999 \
        -e GROUP_ID=995 \
        -e CRYPTO_POLICY=unlimited \
        --restart=always \
        openhab/openhab:latest
