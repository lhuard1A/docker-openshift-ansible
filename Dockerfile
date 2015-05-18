FROM fedora
MAINTAINER Lénaïc Huard <lhuard@amadeus.com>

ADD https://github.com/lhuard1A/openshift-ansible/archive/2015.05.18.tar.gz /openshift-ansible/

RUN yum -y install tar && \
    cd /openshift-ansible && \
    tar -xf 2015.05.18.tar.gz --strip 1 && \
    yum -y erase tar && \
    yum clean all

RUN yum -y install ansible \
                   openssh-clients \
                   python-novaclient \
                   python-neutronclient && \
    yum clean all

RUN ln -s inventory/os/hosts/nova.ini /openshift-ansible

RUN useradd openshift-ansible
RUN mkdir /home/openshift-ansible/.ssh && \
    chown openshift-ansible: /home/openshift-ansible/.ssh && \
    chmod 700 /home/openshift-ansible/.ssh

RUN sed -i 's/\t/        /g' /usr/lib/python2.7/site-packages/ansible/module_utils/facts.py

USER openshift-ansible
WORKDIR /openshift-ansible
ENTRYPOINT ["/openshift-ansible/bin/cluster"]
