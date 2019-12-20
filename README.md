# detect
A collection of Services to implement object detection for open-horizon

# yolov3

This is what the architecture looks like for v3. Containers used are in directories: restcam, yolov3, mqtt, app, and watcher2.

![architecture-diagram](https://raw.githubusercontent.com/MegaMosquito/detect/master/yolov3.png)

In the yolov3 version, the action is driven by the app container. It invokes the REST API provided by the yolov3 container. The yolov3 container in turn invokes the REST API of the restcam container to get an image (base64-encoded, within a JSON structure). Once it gets the image, it runs it through darknet yolo v3-tiny and produces a new image with detected entities annotated and returns a JSON structure with that new image base64-encoded and with an array of detected entity details to the app caller. The app container then sends it out over kafka to the cloud. The app container also posts it to the "/detect" topic on the local MQTT broker (the mqtt container) for debugging purposes. The watcher2 container subscribes to this topic and for debugging purposes renders the results in a browser (its server is available on port 5200).

# yolov2

This is what the architecture looks like for v2. Containers used are in directories: mqtt, cam, yolo, mqtt2kafka, and watcher.

![architecture-diagram](https://raw.githubusercontent.com/TheMosquito/detect/7a989c9246399cc9fa7370ab59e69faf4b72acc5/architecture.png)

In the yolo v2 version, the cam container contually publishes images to the "/cam" topic on the local MQTT broker provided by the mqtt container. The yolo container subscribes to this topic, pulls the images off as it sees them, runs darknet yolo v2-tiny on them, and publishes the results back to the "/detect" topic. The mqtt2kafka container subscribes to "/detect" and it pulls the results off and sends them over klafka to the cloud. The watcher container subscribes to both "/cam" and "/detect" for debugging purposes and renders the data for viewing in a browser (its server is available on port 5200).
