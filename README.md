# Overview
This is a demo that demonstrates how to run a private devfile registry with stacks and deploy it to OpenShift

## Steps to build the registry index image
Follow steps below to build the registry index container image and push it to native container registry within OpenShift. 

* Run commands below to create a BuildConfig resource

    ```
    oc apply -f ./deploy/build.yaml
    ```
* To start the build run command below

    ```
    oc start-build registry-index-build
    ```
## Install the Registry operator
If you haven't installed the DevFile Registry operator run the script below. Script expects operator-sdk installed and in path. So before running the script make sure operator-sdk binary is downloaded and is in path

```
./deploy/installoperator.sh
```

## Create the DevfileRegistry resource
Next we need to create the devfile registry resource. Run command below to create it

```
oc apply -f ./deploy/registry.yaml
```

Be sure to registry pod is up running by running command below

oc get pods -n registry
