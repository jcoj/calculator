#!/bin/bash 
test $(curl "http://172.16.60.68:8765/sum?a=2&b=1") -eq 3
#test $(curl 172.16.60.68:8765/sum=?a=1\&b=2) -eq 3
