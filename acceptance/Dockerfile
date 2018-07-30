FROM ubuntu:trusty
RUN apt-get update && apt-get install -yq curl 
COPY ./src/test.sh .
CMD ["bash","test.sh"]

