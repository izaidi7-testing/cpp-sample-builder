Commands:

sudo docker build -t cpp-builder:0.1 .
sudo /usr/local/bin/s2i build test/test-app/ cpp-builder:0.1 sample-app
sudo docker run sample-app

With Environment  Variable:

sudo /usr/local/bin/s2i build test/test-app/ cpp-builder:0.1 sample-app -e "EXE=hello"
