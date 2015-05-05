FROM fedora
MAINTAINER Lénaïc Huard <lhuard@amadeus.com>

RUN useradd openshift-ansible

ADD https://github.com/lhuard1A/openshift-ansible/archive/35706d4.tar.gz /openshift-ansible/

RUN yum -y install tar && \
    cd /openshift-ansible && \
    tar -xf 35706d4.tar.gz --strip 1 && \
    yum -y erase tar && \
    yum clean all

RUN yum -y install ansible \
                   python-novaclient \
                   python-neutronclient && \
    yum clean all

RUN ln -s inventory/os/hosts/nova.ini /openshift-ansible

USER openshift-ansible
WORKDIR /openshift-ansible
ENTRYPOINT ["/openshift-ansible/bin/cluster"]
