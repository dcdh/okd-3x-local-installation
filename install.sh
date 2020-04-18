#!/bin/bash

# TODO use command line to retrieve ansible_become_password

ansible-playbook install_okd.yaml --extra-vars "ansible_become_password=damien"