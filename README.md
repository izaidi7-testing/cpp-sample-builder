Commands:

sudo docker build -t cpp-builder:0.1 .
sudo /usr/local/bin/s2i build test/test-app/ cpp-builder:0.1 sample-app
sudo docker run sample-app

With Environment  Variable:
sudo /usr/local/bin/s2i build test/test-app/ openvino-cpp-builder:latest sample-openvino-app -e "PRE_BUILD_SCRIPT=pre-build-script.sh" -e "CMAKE_ARGS=-DCMAKE_BUILD_TYPE=Release" -e "CMAKE_BUILD_ARGS=--target crossroad_camera_demo" -e "POST_BUILD_SCRIPT=post-build-script.sh" -e "ENTRY_POINT=run.sh" -e "CONTEXT_DIR=open_model_zoo-2021.4/demos"
