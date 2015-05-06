openshift-ansible docker image
==============================

The `lhuard1a/openshift-ansible` docker image requires the OpenStack credentials environment variables.

Once the `.keystonerc` file is sourced, the below commands will take care of forwarding the appropriate environment variables.

Create a new cluster
--------------------

```
docker run --rm -e OS_USERNAME=$OS_USERNAME -e OS_PASSWORD=$OS_PASSWORD -e OS_TENANT_NAME=$OS_TENANT_NAME -e OS_AUTH_URL=$OS_AUTH_URL lhuard1a/openshift-ansible create os <cluster-id>
```

List the machines of a cluster
------------------------------

```
docker run --rm -e OS_USERNAME=$OS_USERNAME -e OS_PASSWORD=$OS_PASSWORD -e OS_TENANT_NAME=$OS_TENANT_NAME -e OS_AUTH_URL=$OS_AUTH_URL lhuard1a/openshift-ansible list os <cluster-id>
```

Terminate a cluster
-------------------

```
docker run --rm -e OS_USERNAME=$OS_USERNAME -e OS_PASSWORD=$OS_PASSWORD -e OS_TENANT_NAME=$OS_TENANT_NAME -e OS_AUTH_URL=$OS_AUTH_URL lhuard1a/openshift-ansible terminate os <cluster-id>
```
