{% elif vm_ip == okd_master_ip %}

########################################################################################################################
# OKD Master init configuration
########################################################################################################################

TODO je dois passer par un registry avant !!! je dois servir les fichiers depuis celui-ci ...

je dois configurer le registry docker utiliser dans l'image centos 7 ...

je creer une images fedora core os puis je push mes images centos dedans et enfin je creer la master okd avec le registre mirror docker :)

est ce que je peux faire du jinja template unit test ???
todo nfs vm ???

1. Registre mirror docker
1.1 test pull docker.io and quay.io ... (en mode debug pour tester l'affichage)


supprimer la notion de is_dns_vm et utiliser l'adresse ip directement !!!!


docker --log-level=debug pull docker.io/openshift/oauth-proxy:v1.1.0
docker --log-level=debug pull docker.io/openshift/origin-cluster-monitoring-operator:v3.11

docker --log-level=debug pull quay.io/coreos/cluster-monitoring-operator:v0.1.1


coreos/cluster-monitoring-operator:v0.1.1

ssh damien@container-registry.okd.local 'skopeo copy docker://quay.io/coreos/cluster-monitoring-operator:v0.1.1 docker://container-registry.okd.local/coreos/cluster-monitoring-operator:v0.1.1 --dest-tls-verify=false'
ssh damien@container-registry.okd.local 'skopeo copy docker://docker.io/openshift/origin-cluster-monitoring-operator:v3.11 docker://container-registry.okd.local/openshift/origin-cluster-monitoring-operator:v3.11 --dest-tls-verify=false'



/// Marche pas
depuis host
ssh damien@container-registry.okd.local 'skopeo copy docker://docker.io/openshift/origin-cluster-monitoring-operator:v3.11 docker://container-registry.okd.local/docker.io/openshift/origin-cluster-monitoring-operator:v3.11 --dest-tls-verify=false'
ssh damien@container-registry.okd.local 'skopeo copy docker://quay.io/coreos/cluster-monitoring-operator:v0.1.1 docker://container-registry.okd.local/quay.io/coreos/cluster-monitoring-operator:v0.1.1 --dest-tls-verify=false'

depuis master.okd.local
docker pull docker.io/openshift/origin-cluster-monitoring-operator:v3.11
docker pull quay.io/coreos/cluster-monitoring-operator:v0.1.1

/// 

mirrors:
- container-registry.sandbox.okd.local/openshift
source: quay.io/openshift

////////////////////////////////////////////////////////////////////////////////////
// Fonctionne

- depuis host
ssh damien@container-registry.okd.local 'skopeo copy docker://docker.io/openshift/origin-cluster-monitoring-operator:v3.11 docker://container-registry.okd.local/docker.io/openshift/origin-cluster-monitoring-operator:v3.11 --dest-tls-verify=false'
ssh damien@container-registry.okd.local 'skopeo copy docker://quay.io/coreos/cluster-monitoring-operator:v0.1.1 docker://container-registry.okd.local/quay.io/coreos/cluster-monitoring-operator:v0.1.1 --dest-tls-verify=false'

depuis master.okd.local
transfer all images from container-registry and next tag them
docker pull container-registry.okd.local/docker.io/openshift/origin-cluster-monitoring-operator:v3.11
docker pull container-registry.okd.local/quay.io/coreos/cluster-monitoring-operator:v0.1.1

docker image tag container-registry.okd.local/docker.io/openshift/origin-cluster-monitoring-operator:v3.11 docker.io/openshift/origin-cluster-monitoring-operator:v3.11
docker image tag container-registry.okd.local/quay.io/coreos/cluster-monitoring-operator:v0.1.1 quay.io/coreos/cluster-monitoring-operator:v0.1.1

and next this work
docker pull quay.io/coreos/cluster-monitoring-operator:v0.1.1


Docker does not support private registry ... something that podman can do ... however I am stuck to docker 1.13.
Hopefully a workaround exists.
1. first copy all images from external registries (docker.io and quay.io) into registry in container-registry guest virtual machine
2. copy all images from container-registry into target guest virtual machine
3. tag all image to remove reference of container-registry.okd.local
When a pull will be made in the guest virtual machine, docker will first check if the image is present and reuse it (
event if the image was pulled from quay.io in private container registry)
A workaround not merged https://www.suse.com/c/hackweek-project-docker-registry-mirror/
