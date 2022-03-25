# Overview
This is a demo that demonstrates how to run a private devfile registry with stacks and deploy it to OpenShift

## Steps to build the docker image
Follow steps to build the docker image and push it to a docker registry. In this example I'm pushing the docker image to internal docker registry in OpenShift, its not required, docker image can be pushed to any docker registry you might be using.

### Pre-requisites
Before you can build the image we need to make sure the container registry native to Openshift is exposed from accessing from outside the cluster. This section will cover how to check the default route and create one if default route doesn't exist

* Checking default route for container registry native to openshift

```
oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}'
```

* If the above command did not show any routes then run the command below to create the default route

```
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
```

## Building the docker image and push it to container registry native to your OpenShift cluster
Open terminal and run the build.sh script as shown below

```
./build.sh
```
