FROM fedora
MAINTAINER Lénaïc Huard <lhuard@amadeus.com>


# Add openshift-ansible user

RUN useradd openshift-ansible
RUN mkdir /home/openshift-ansible/.ssh && \
    chown openshift-ansible: /home/openshift-ansible/.ssh && \
    chmod 700 /home/openshift-ansible/.ssh


# Install openshift-ansible dependencies

RUN yum -y install ansible \
                   openssh-clients \
                   python-novaclient \
                   python-neutronclient \
                   python-heatclient && \
    yum clean all


# Backport https://github.com/ansible/ansible/pull/10639

RUN sed -i 's/\t/        /g' /usr/lib/python2.7/site-packages/ansible/module_utils/facts.py


# Install openshift-ansible

ADD https://github.com/lhuard1A/openshift-ansible/archive/2015.05.21.tar.gz /openshift-ansible/

RUN yum -y install tar && \
    cd /openshift-ansible && \
    tar -xf 2015.05.21.tar.gz --strip 1 && \
    yum -y erase tar && \
    yum clean all

RUN ln -s inventory/os/hosts/nova.ini /openshift-ansible


# Override some openshift-ansible default settings with my own

ADD personal_settings.patch /openshift-ansible/

RUN yum -y install patch && \
    cd /openshift-ansible && \
    patch -p1 < personal_settings.patch && \
    yum -y erase patch && \
    yum clean all

USER openshift-ansible
WORKDIR /openshift-ansible
ENTRYPOINT ["/openshift-ansible/bin/cluster"]
