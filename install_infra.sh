#!/bin/bash

ansible-playbook install_infra.yml --ask-become-pass


# TODO dynamic

ansible-playbook -i /home/damien/.okd/vms/master.okd.local/openshift-ansible/inventory.ini /home/damien/.okd/vms/master.okd.local/openshift-ansible/playbooks/prerequisites.yml
ansible-playbook -i /home/damien/.okd/vms/master.okd.local/openshift-ansible/inventory.ini /home/damien/.okd/vms/master.okd.local/openshift-ansible/playbooks/deploy_cluster.yml

ssh damien@master.okd.local 'oc adm policy add-cluster-role-to-user cluster-admin damien'
