# Running Open-Source Machine-Learning Models On-Premises

## This talk in one diagram

"Providing access to Open-Source Machine-Learning via self-hosted Web-Services for Inference"

## What does it have to do with medicine?

This setup is necessary for many applications in medicine dealing with AI for several reason.

In medicine, there is need for
+ Data Security,e.g. because of sensitive data
* Transparency & Reliability, e.g. for science and traceable services
* Autonomy & Avalability, e.g. for not being dependent on internet providers
* Adaptability, e.g. in terms of fine-tuning
* ...

## Open-Source Machine-Learning Models (OSMLMs)

* OSMLMs are ML models available under an Open-Source License (e.g. Apache 2.0)
* Sources: HuggingFace, Github
* Open-Source models differs in terms of transparency, reproducibility and quality control --> Do not confuse Open-Source with Openness!

## Motivation for use of Open-Source Machine-Learning Models

* Transparency and Reliability 
* Availability
* Adaptability
* Performance
* Autonomy (avoiding Vendor-Lock-Ins)
* Cost-Saving

## On-Premises

On-prem: Deployment and operations within physical premises of a company/organization

--> Full control over IT infrastructure, data and application.

## Motivation for running Models on-premises

* Data Security and Privacy
* Latency and Performance
* Autonomy Offline Access
* Control over intellectual property
* Cost-Saving 
* Flexibility, if you make use of a Cloud-agnostic deployment strategy

## Cloud-agnostic deployment strategy

Deployment (Applications, tools and services) designed to migrate seamlessly between multiple cloud platforms and on-premises.

## Kubernetes

"Kubernetes (k8s) is a ...
* open-source
* container orchestration system
* for automating
* software deployment, 
* scaling,
* and management."

Kubernetes simplified from a user perspective: web service that can be used to manage and automate processes on many computers

## KServe: Model Inference Platform on Kubernetes

KServe
* open-source
* offers (auto)scaling, e.g. 
    * if number of requests increaes or 
    * if there is no load at all (Scale to zero)
* standardized inference protocol across ML frameworks and Model Serving Runtimes
* simplifies production-ready model deployment (scaling, monitoring, advanced deployments)

## Example: Steps to run a Model for ImageClassification from torch.hub on Kubernetes

### Setup

* local Kubernetes-Cluster based on Minikube
* KServe is already installed
* Model for Image Recognition: resnet18 from torch.hub
* Model files were already downloaded

### Steps 

1) Preparing the model files: create a MAR file so that torchserve can work with the model
2) Upload the MAR file 
3) Creating an InferenceService with references to the location of the model and the model serving runtime to be used.
4) Prepare and classify images via HTTP requests.

## Summary

* Open-Source Machine-Learning Models have a lot of advantages.
* There are many reasons why it may be appropriate or even necessary to deploy models on-premises.
* You can gain high flexibility by choosing a cloud-agnostic approach.
* Kubernetes is a key technology for implementing a cloud-agnostic deployment strategy.
* KServe is a inference platform suited for deploying models in production on Kubernetes.

## Sources

* HuggingFace: [https://huggingface.co/](https://huggingface.co/)
* Openness: [https://arxiv.org/pdf/2307.05532.pdf](https://arxiv.org/pdf/2307.05532.pdf)
* Cloud-agnostic: [https://tanzu.vmware.com/cloud-agnostic](https://tanzu.vmware.com/cloud-agnostic)
* Kubernetes: [https://kubernetes.io/](https://kubernetes.io/)
* KServe: [https://kserve.github.io/website/0.11/](https://kserve.github.io/website/0.11/)
* Resnet: [https://pytorch.org/hub/pytorch_vision_resnet/](https://pytorch.org/hub/pytorch_vision_resnet/)
* 