#!/bin/bash
set -e

mvn install -DskipTests -Dmaven.javadoc.skip=true #&& mvn dockerfile:build -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP
#mvn dockerfile:tag@tag-version -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP
printf "Start building images"
ls
cd FROST-Server.HTTP && docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 --tag adriancierpka/frost-server-http:latest
cd ..
cd FROST-Server.MQTT && docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 --tag adriancierpka/frost-server-mqttp:latest
cd ..
cd FROST-Server.MQTTP && docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 --tag adriancierpka/frost-server:latest
cd ..

if [ "${TRAVIS_BRANCH}" = "master" ]; then
  mvn dockerfile:push@push-latest -Ddockerfile.useMavenSettingsForAuth=true -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP --settings travis-settings.xml
fi

mvn dockerfile:push@push-version -Ddockerfile.useMavenSettingsForAuth=true -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP --settings travis-settings.xml
