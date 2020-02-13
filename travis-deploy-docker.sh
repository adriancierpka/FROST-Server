#!/bin/bash
set -e

mvn install -DskipTests -Dmaven.javadoc.skip=true && mvn dockerfile:build -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP
#mvn dockerfile:tag@tag-version -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 -t adriancierpka/frost-server:latest 

if [ "${TRAVIS_BRANCH}" = "master" ]; then
  mvn dockerfile:push@push-latest -Ddockerfile.useMavenSettingsForAuth=true -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP --settings travis-settings.xml
fi

mvn dockerfile:push@push-version -Ddockerfile.useMavenSettingsForAuth=true -pl FROST-Server.HTTP,FROST-Server.MQTT,FROST-Server.MQTTP --settings travis-settings.xml
