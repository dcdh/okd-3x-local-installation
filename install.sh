#!/bin/bash

# Ensure virtualization is available on host
if ! lscpu | grep 'VT-x'
then
  echo "CPU does not support virtualization"
  exit 1
fi

