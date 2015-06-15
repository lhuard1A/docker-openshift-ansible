openshift-ansible docker image
==============================

The `lhuard1a/openshift-ansible` docker image packages [openshift-ansible](https://github.com/openshift/openshift-ansible) with all the dependencies required to operate an OpenStack cluster.

In order to work properly, the `lhuard1a/openshift-ansible` docker image has some requirements.

The easiest way to use it is to use the [`docker-openshift-ansible script`](https://github.com/lhuard1A/docker-openshift-ansible-os/blob/2015.06.15/docker-openshift-ansible) that can be downloaded at the following url: https://raw.githubusercontent.com/lhuard1A/docker-openshift-ansible-os/2015.06.15/docker-openshift-ansible

Pre-requisites:
---------------

* Have the `OS_USERNAME`, `OS_PASSWORD`, `OS_TENANT_NAME` and `OS_AUTH_URL` environment variables set by having sourced your `.keystonerc` file.
* Have a `$HOME/.ssh/id_rsa.pub` file containing the ssh public key that will be used on created VMs.
* Have a local ssh agent listening on `$SSH_AUTH_SOCK` and containing the corresponding ssh private key.

Usage:
------

### Create a new cluster

```
docker-openshift-ansible create os <cluster-id>
```

### List the machines of a cluster

```
docker-openshift-ansible list os <cluster-id>
```

### Terminate a cluster

```
docker-openshift-ansible terminate os <cluster-id>
```
