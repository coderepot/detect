
register-v3:
	hzn register --pattern "${HZN_ORG_ID}/pattern-yolov3" --input-file ./patterns/yolov3-input.json

register-v2:
	hzn register --pattern "${HZN_ORG_ID}/pattern-yolo" --input-file ./patterns/yolo-input.json

publish-pattern-v3:
	hzn exchange pattern publish -f patterns/pattern-yolov3.json

publish-all-patterns-v2:
	hzn exchange pattern publish -f patterns/pattern-yolo-all.json

test-all-v3:
	make -C mqtt
	make -C mqtt test-broker
	make -C restcam
	make -C restcam test-cam
	make -C watcher2
	make -C watcher2 test-watcher
	make -C yolov3
	make -C yolov3 test-yolov3
	make -C app
	make -C app test-app

test-all-v2:
	make -C mqtt
	make -C mqtt test-broker
	make -C cam
	make -C cam test-cam
	make -C watcher
	make -C watcher test-watcher
	make -C yolo
	make -C yolo test-yolo
	make -C mqtt2kafka
	make -C mqtt2kafka test-kafka

clean-docker-containers:
	-docker rm -f `docker ps -aq` 2>/dev/null || :
	-docker network rm mqtt-net 2>/dev/null || :

clean-docker-all:
	-docker rm -f `docker ps -aq` 2>/dev/null || :
	-docker network rm mqtt-net 2>/dev/null || :
	-docker rmi -f `docker images -aq` 2>/dev/null || :

publish-all-v3:
	make -C mqtt
	make -C mqtt push
	make -C mqtt publish-service
	make -C restcam
	make -C restcam push
	make -C restcam publish-service
	make -C yolov3
	make -C yolov3 push
	make -C yolov3 publish-service
	make -C app
	make -C app push
	make -C app publish-service
	make -C watcher2
	make -C watcher2 push
	make -C watcher2 publish-service


publish-all-v2:
	make -C mqtt
	make -C mqtt push
	make -C mqtt publish-service
	make -C cam
	make -C cam push
	make -C cam publish-service
	make -C watcher
	make -C watcher push
	make -C watcher publish-service
	make -C yolo
	make -C yolo push
	make -C yolo publish-service
	make -C mqtt2kafka
	make -C mqtt2kafka push
	make -C mqtt2kafka publish-service
