#!/bin/bash

sleep 60
test $(curl "http://calculator:8080/sum?a=2&b=1") -eq 3

