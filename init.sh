#!/bin/sh

set -euo pipefail

useradd -u $UID -d $HOME -M openshift-ansible
chown openshift-ansible: $HOME $HOME/.ssh
chmod 700 $HOME/.ssh

[[ -z "$KVM_GID" ]] || groupadd -g $KVM_GID kvm

exec su openshift-ansible -c "/openshift-ansible/bin/cluster $*"
