# Running Open-Source Machine-Learning Models On-Premises

Material for the Talk at [ETIM 2024](https://etim.uk-essen.de/)

## Presentation

The slides can be found [here](./presentation/).

## Demo

### Requirements

* to set up the local Kubernetes cluster that is required to run the demo, follow the instructions on [https://github.com/grothesk/kserve-on-minikube](https://github.com/grothesk/kserve-on-minikube)
* download the model files like this:
```bash
make download-model-files 
```

### Steps to perform

For running the demo, perform the following steps:

1. Package model files (MAR) so that `torchserve`as model serving runtime can work with the
model:
```bash
make create-mar
```

2. Create the required directory structure on the object storage and upload the MAR file and the `config.properties`:
```bash
make create-model-buckets upload-model-files
```

3. Create an `InferenceService` resource including references to the location of the model files and the model serving runtime to be used: 
´´´bash
make deploy-inference-service
´´´

4. Prepare the image of the good boy and classify it via HTTP requests:
```bash
IMAGE=dog make convert-jpg-to-json classify-picture-of-cute-animal
```

5. Do the same for another cute animal:
```bash
IMAGE=shark make convert-jpg-to-json classify-picture-of-cute-animal
```
