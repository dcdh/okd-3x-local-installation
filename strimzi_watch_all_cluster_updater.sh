#!/bin/bash

SCRIPT_PATH=$(dirname $0)
sed -n -i.bak '/.*valueFrom/{:a;N;/.*namespace/!ba;N;s/.*\n/          value: "*"\n/};p' $SCRIPT_PATH/050-Deployment-strimzi-cluster-operator.yaml
