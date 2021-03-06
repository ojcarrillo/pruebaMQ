#!/bin/bash
echo "======================================================="
echo "compila aplicacion"
mvn clean package -Dmaven.test.skip=true
echo "======================================================="
echo "======================================================="
echo "compila imagen docker - dk_fstransporte"
docker build -t testmq .
echo "======================================================="
echo "======================================================="
echo "corre imagen del contenedor"
docker run --name testmq --net=backend \
-d -p 2021:21 -p 2020:20 -p 12020:12020 -p 12021:12021 -p 12022:12022 -p 12023:12023 -p 12024:12024 -p 12025:12025  \
-e "USER=touresbalon" -e "PASS=verysecretpwd" \
-v /data/ftp/oda:/ftp \
-it testmq
echo "======================================================="
echo "======================================================="
echo "fin"
docker exec -it testmq bash
