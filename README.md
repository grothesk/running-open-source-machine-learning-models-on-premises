# Running Open-Source Machine-Learning Models On-Premises

Material for the Talk at [ETIM 2024](https://etim.uk-essen.de/)

## Presentation

The slides can be found [here](./presentation/).

## Example

For running the example, see the `Makefile`.

### Steps
1. Packaging model files (MAR) so that torchserve can work with the
model
2. Uploading the MAR file to S3 storage on the cluster
3. Creating an InferenceService with references to the location of the model files and the model serving runtime to be used
4. Preparing images and classifying them via HTTP requests
