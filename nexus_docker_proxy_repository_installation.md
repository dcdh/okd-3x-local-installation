# Add docker proxy repository

keywords: **docker.io**, **proxy**

The objective is to proxify docker hub images to speed up images pulling afterward by using it.

## Manual installation

I did not manage to do it automatically. Maybe I will do it in a near `future`.

### Create docker hub repository

1. connect to nexus using admin right
1. go to `Repository > Repositories`
1. in the screen `Repositories` click on the button `Create repository`
1. from the list of repositories types click on `docker (proxy)`
1. fill the form with theses values:
- name: docker-hub
- http: 8082
- uncheck **Force basic authentication**
- check **Allow clients to use the V1 API to interact with this Repository**
- Location of the remote repository being proxied: https://registry-1.docker.io
- Docker Index: Use Docker Hub

> keep other options defined
>
> click on `Create repository`

### Setup anonymous pull

> The force basic authentication has been unchecked in the docker hub setup. However, another configuration has 
> to be made to pull image from this repository anonymously.

1. go to `Security > Realms`
1. add `Docker Bearer Token Realm` in `Active` column
1. click on `Save`

## References

> https://stackoverflow.com/questions/36875832/nexus-docker-registry-failling-anonymous-pull
