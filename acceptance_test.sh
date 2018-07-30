#!/bin/bash

CALCULATOR_PORT=$(docker-compose port calculator 8080 | cut -d : -f2) 
test $(curl "http://172.16.60.68:$CALCULATOR_PORT/sum?a=2&b=1") -eq 3
#test $(curl 172.16.60.68:8765/sum=?a=1\&b=2) -eq 3
