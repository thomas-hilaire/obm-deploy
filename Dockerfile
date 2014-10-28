##
## The centos target
##
FROM centos:6.4

RUN yum install -y openssh-server openssh-clients

# Configure SSH server
# Create admin account
RUN mkdir -p /var/run/sshd && chmod -rx /var/run/sshd && \
	ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key && \
	sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
	sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
	sed -ri 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/sshd_config && \
	useradd -m -G users,root -p $(openssl passwd -1 "admin") admin && \
	echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD docker/.ssh/authorized_keys /root/.ssh/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]



##
## The deployer
##
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y git python-dev wget ansible python-virtualenv python-pip virtualenvwrapper 

# RUN mkdir /obm-deploy

ADD . /obm-deploy

WORKDIR /obm-deploy

RUN ["virtualenv", "--no-site-packages", "obm-deploy-env"]

RUN ["/bin/bash", "-c", "source obm-deploy-env/bin/activate"]

RUN pip install paramiko PyYAML jinja2 pyasn1 pycrypto python-keyczar==0.71b

RUN git clone https://github.com/ansible/ansible -b release1.7.2

RUN ["/bin/bash", "-c", "source ansible/hacking/env-setup"]

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN mkdir /root/.ssh/

ADD docker/.ssh/* /root/.ssh/

CMD ["/bin/bash", "-c", "./docker/run.sh"]