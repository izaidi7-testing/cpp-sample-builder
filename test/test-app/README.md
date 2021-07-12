# Builder Exploration

Setup: download open model zoo release (omz) for sample and docker_ci for base images (already checked into repo)
```
wget https://github.com/openvinotoolkit/open_model_zoo/archive/refs/tags/2021.4.tar.gz -O omz-2021.4.tar.gz
wget https://github.com/openvinotoolkit/docker_ci/archive/refs/tags/2021.4.tar.gz -O docker_ci-2021.4.tar.gz
```
Extract and start using docker_ci
```
tar -xvzf docker_ci-2021.4.tar.gz
cd docker_ci-2021.4
```

### Generate dockerfile (to view later/backup)
```
python3 docker_openvino.py gen_dockerfile \
        --distribution data_dev \
        --product_version 2021.4 \
        -os ubuntu18 \
        --build_arg no_samples=True \
        --dockerfile_name builder_base_data_dev_2021.4.dockerfile
```

### Build base builder image
```
python3 docker_openvino.py build \
        --file dockerfiles/ubuntu18/builder_base_data_dev_2021.4.dockerfile \
        --distribution data_dev \
        --product_version 2021.4 \
        -os ubuntu18 \
        --build_arg no_samples=True \
        --tags devcloud/ubuntu18_data_dev:2021.4
```

### Build sample app docker iamge
```
time docker build -f data_dev_cpp_crossroad_camera_demo.dockerfile -t devcloud/data_dev_crossroad_camera_demo:2021.4 --no-cache .
```
Note: 1min6sec (compile & build cpp docker image)

### Run sample app docker image (use mount to extract/verify results)
```
// run as non-root default openvino user
docker run --rm -v ${PWD}/test-result:/home/openvino/results devcloud/data_dev_crossroad_camera_demo:2021.4
```
[Optional] To run as root `docker run --rm -u 0 -v ${PWD}/test-result:/app/results devcloud/data_dev_crossroad_camera_demo:2021.4`


### Multi-stage ubuntu18 runtime docker image for sample apps
```
// build data_runtime image
python3 docker_openvino.py build \
        --distribution data_runtime \
        --product_version 2021.4 \
        -os ubuntu18 \
        --build_arg no_samples=True \
        --tags devcloud/ubuntu18_data_runtime:2021.4
```
```
time docker build -f ubuntu18_multi_stage_build.dockerfile -t devcloud/data_runtime_cpp_crossroad_camera_demo:2021.4 --no-cache .
docker run --rm -v ${PWD}/test-result:/home/openvino/results devcloud/data_runtime_cpp_crossroad_camera_demo:2021.4
```

### [FAILED] Multi-stage rhel8 runtime docker image for sample apps

**Note:** 
- rhel8 container images are runtime only, not dev purposes. i.e. no cmake 
- Tried to download/convert using ubuntu18_dev as builder and then copy into rhel8_runtime. **[failed]**
- limitation is no VPU/HDDL support in rhel, no support for dev or data_dev images