MODEL_NAME ?= resnet-18
MODEL_SERVICE ?= "" 
MODEL_PATH := ${MODEL_NAME}

IMAGE ?= kitten

CLUSTER_NAME := kserve.minikube

MINIO_ACCESS_KEY := minio
MINIO_SECRET_KEY := minio123

.PHONY: download-model-files
download-model-files:
	curl https://download.pytorch.org/models/resnet18-f37072fd.pth --output downloads/resnet18-f37072fd.pth
	curl https://raw.githubusercontent.com/pytorch/serve/master/examples/image_classifier/resnet_18/index_to_name.json --output downloads/index_to_name.json
	curl https://raw.githubusercontent.com/pytorch/serve/master/examples/image_classifier/resnet_18/model.py --output downloads/model.py

.PHONY: create-mar
create-mar:
	pipenv run torch-model-archiver --model-name ${MODEL_NAME} --version 1.0 --model-file ./downloads/model.py \
		--serialized-file ./downloads/resnet18-f37072fd.pth --handler image_classifier --extra-files ./downloads/index_to_name.json
	mv ${MODEL_NAME}.mar model/model-store

.PHONY: start-torchserve
start-torchserve:
	pipenv run torchserve --start --model-store model/model-store --models ${MODEL_NAME}=${MODEL_NAME}.mar

.PHONY: stop-torchserve
stop-torchserve:
	pipenv run torchserve --stop

.PHONY: infer-torchserve
infer-trochserve:
	curl http://127.0.0.1:8080/predictions/resnet-18 -T ./images/${IMAGE}.jpg

.PHONY: create-model-buckets
create-model-buckets:
	mc config host add model-storage http://minio.${CLUSTER_NAME}:9000 ${MINIO_ACCESS_KEY} ${MINIO_SECRET_KEY}
	mc mb model-storage/models/torchserve/resnet-18/1.0/config
	mc mb model-storage/models/torchserve/resnet-18/1.0/model-store

.PHONY: upload-model-files
upload-model-files:
	mc cp model/config/config.properties model-storage/models/torchserve/resnet-18/1.0/config/config.properties 
	mc cp model/model-store/resnet-18.mar model-storage/models/torchserve/resnet-18/1.0/model-store/resnet-18.mar

.PHONY: convert-jpg-to-json
convert-jpg-to-json:
	pipenv run python scripts/tobytes.py images/${IMAGE}.jpg

.PHONY: infer-resnet
infer-resnet:
	curl -v http://resnet-18-predictor.examples.${CLUSTER_NAME}/v1/models/resnet-18:predict \
    -H 'accept: application/json' -H 'Content-Type: application/json' \
    --data @./images/${IMAGE}.json | jq 

.PHONY: clean-project
clean-project:
	rm images/*.json