#!/bin/bash -
test $(curl "http://127.0.0.1:8765/sum=?a=1\&b=2") -eq 3
