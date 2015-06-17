FROM fedora:22
MAINTAINER Lénaïc Huard <lhuard@amadeus.com>


# Install openshift-ansible dependencies

RUN dnf -y install ansible \
                   openssh-clients \
                   \
                   python-novaclient \
                   python-neutronclient \
                   python-heatclient \
                   \
                   libvirt-python \
                   genisoimage && \
    dnf clean all


# Backport https://github.com/ansible/ansible/pull/10639

RUN sed -i 's/\t/        /g' /usr/lib/python2.7/site-packages/ansible/module_utils/facts.py


# Install openshift-ansible

ADD https://github.com/lhuard1A/openshift-ansible/archive/2015.06.17.tar.gz /openshift-ansible/

RUN dnf -y install tar && \
    cd /openshift-ansible && \
    tar -xf 2015.06.17.tar.gz --strip 1 && \
    dnf -y erase tar && \
    dnf clean all

RUN ln -s inventory/openstack/hosts/nova.ini /openshift-ansible


# Override some openshift-ansible default settings with my own

ADD personal_settings.patch /openshift-ansible/

RUN dnf -y install patch && \
    cd /openshift-ansible && \
    patch -p1 < personal_settings.patch && \
    dnf -y erase patch && \
    dnf clean all


# Add init.sh

COPY init.sh /


#USER openshift-ansible
WORKDIR /openshift-ansible
ENTRYPOINT ["/init.sh"]
