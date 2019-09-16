#!/usr/bin/env bash
set -e
set -x

mkdir -p ./bin
go build  -o ./bin/server  server.go
go build  -o ./bin/forward forward.go

./bin/server &
sudo ./bin/forward &
sleep 2

curl http://127.0.0.1:80/hello -H 'BACKEND: 127.0.0.1:8080'
curl https://127.0.0.1:443/hello -H 'BACKEND: 127.0.0.1:8081' --cacert ./pki/ca.crt