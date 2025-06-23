# custom-inference-server-for-watsonx.ai

This repo contains a simple example of a custom inference server which can be deployed in the software version of watsonx.ai. See the documentation [Building a custom inference runtime image for your custom foundation model](
https://www.ibm.com/docs/en/software-hub/5.2.x?topic=dcfm-building-custom-inference-runtime-image-your-custom-foundation-model) for details.

The example is only a mock and doesn't invoke models. It implements the OpenAI-compatible API for chat completions `/v1/chat/completions`.

---

## 🐳 Docker Base Image Requirement

This project is designed to run on top of a base image provided by IBM Cloud Pak for Data (CPD). Users must follow the documented steps to retrieve the base image associated with the Software Specification named:

```bash
runtime-24.1-py3.11-cuda
```

This image should be pulled from the CPD container registry based on the runtime definition associated with the software spec "runtime-24.1-py3.11-cuda". Once retrieved, it must be used as the FROM base image in the Dockerfile to build the custom-inference-server container.

## How to Pull the Base Image

To build the Docker image, you first need to pull the base image associated with the CPD software spec "runtime-24.1-py3.11-cuda"


This image is hosted in the **IBM Cloud Pak for Data (CPD) container registry** (`cp.icr.io`) and requires authentication.

Follow these steps:

1. Authenticate to the IBM Container Registry:

```bash
podman login -u <user> -p <password> cp.icr.io/cp/cpd/
```

2. Pull the correct version of the runtime image (replace <tag> with the version specific to your CPD deployment):

```bash
podman pull cp.icr.io/cpd/base/runtime-24.1-py3.11-cuda:<tag>
```

3. (Optional) Tag it locally for use in the Dockerfile:

```bash
podman tag cp.icr.io/cpd/base/runtime-24.1-py3.11-cuda:<tag> runtime-24.1-py3.11-cuda
```

## How to build the Custom Image

1. Build the custom image using the Dockerfile

```bash
podman build -t custom-image:test-1 \
		    --build-arg base_image_tag=cp.icr.io/cp/cpd/custom-image:test-1 \
			-f Dockerfile`
```

## How to push the Custom Image to the CPD registry

1. Push the custom image to CPD registry
```bash
podman push cp.icr.io/cp/cpd/custom-image:test-1
```
