TASK [metrics_server : fetch existing metrics-server secret] ******************************************************************************************************************************************************
fatal: [10.0.5.50]: FAILED! => {"changed": false, "cmd": ["oc", "-n", "openshift-metrics-server", "--config=/tmp/openshift-metrics-server-ansible-ttSmz3/admin.kubeconfig", "get", "secret", "metrics-server-certs", "-o", "json"], "delta": "0:00:00.168833", "end": "2020-04-27 12:22:49.951861", "msg": "non-zero return code", "rc": 1, "start": "2020-04-27 12:22:49.783028", "stderr": "Error from server (NotFound): secrets \"metrics-server-certs\" not found", "stderr_lines": ["Error from server (NotFound): secrets \"metrics-server-certs\" not found"], "stdout": "", "stdout_lines": []}



priorité:
1. crée toute l'infrastrcture todo app
- environnements (prod, recette, build): regarder des examples
- build
- infra monitoring + logging + metrics AKA exploitation infrastructure
- istio
automatiser a mort !!!

utiliser que des cluster operators pour l infra ... (kafka, postgresql)
- pour postgresql je dois builder ma propre image ...

single active load balancer rest ??

2. splitter l'infrastructure en plusieurs machines
8GB chacune et 2 VCPU

master-node
ci-cd-node (jenkins, nexus)
data-infra-node logging, metrics, monitoring using NFS
prod-node (local persistence) kafka, database
hom-node stateless
e2e-node stateless

3. configurer les logs pour n'ecouter que la production
TADAM !!!


Glusterfs comme persistent volume a la place du hostPath !


renommer install_okd to install_okd_infra

rajouter le matchlabels dans mon statefulll postgresql :)
