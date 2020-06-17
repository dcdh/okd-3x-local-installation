# Fix jenkins build
> An issue is present following the last version of **openshift/jenkins-agent-maven-35-centos7:v3.11**
> https://github.com/openshift/jenkins/issues/997
> We need to downgrade the version of jenkins used to this commit id **e2a35ea**
> /!\ I do not know if earlier one from **e2a35ea** are working.
>
> **TODO** Use ansible to automatise it

Follow theses steps to downgrade your version of Jenkins

1. oc scale --replicas=0 dc jenkins
1. git clone https://github.com/openshift/jenkins.git
1. cd jenkins
1. git checkout e2a35ea
1. make build
1. docker tag docker.io/openshift/jenkins-agent-maven-35-centos7:latest docker.io/openshift/jenkins-agent-maven-35-centos7:e2a35ea
1. docker tag docker.io/openshift/jenkins-2-centos7:latest 172.30.247.189:5000/openshift/jenkins-2-centos7:e2a35ea
1. oc login -u sandbox -p sandbox (log to openshift using our appropriate username and passord)
1. docker login -u openshift -p $(oc whoami -t) 172.30.247.189:5000
1. docker push 172.30.247.189:5000/openshift/jenkins-2-centos7:e2a35ea
1. purge volume used by previous jenkins version (if using persistent jenkins template)
> If you've used a persistent version of jenkins deployment, you'll need to purge the filesystem bound to it.
> However, the previous configuration, plugins... will clash with the ones used by this image.
> Do not worry. When Jenkins will be restarted it will setup all pipelines from the ones defined in OpenShift.
1. oc set triggers dc/jenkins --from-image=openshift/jenkins-2-centos7:e2a35ea --containers=jenkins
1. oc scale --replicas=1 dc jenkins

