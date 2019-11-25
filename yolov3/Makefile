all: build run

build:
	docker build -t ibmosquito/yolov3:1.0.0 -f ./Dockerfile .

dev:
	-docker rm -f yolov3 2>/dev/null || :
	docker run -it --name yolov3 -e HZN_DEVICE_ID=`hostname` -p 5252:80 -v `pwd`:/outside --network=cam --net-alias=yolov3 ibmosquito/yolov3:1.0.0 /bin/bash

run:
	-docker rm -f yolov3 2>/dev/null || :
	docker run --rm -d --name yolov3 -e HZN_DEVICE_ID=`hostname` -p 5252:80 --network=cam --net-alias=yolov3 ibmosquito/yolov3:1.0.0


