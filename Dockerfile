FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y git python-dev wget ansible python-virtualenv python-pip virtualenvwrapper 

ADD . /obm-deploy

WORKDIR /obm-deploy

RUN git clone https://github.com/ansible/ansible -b release1.7.2

RUN ["virtualenv", "--no-site-packages", "obm-deploy-env"]

RUN ["/bin/bash", "-c", "source obm-deploy-env/bin/activate"]

RUN pip install paramiko PyYAML jinja2 pyasn1 pycrypto python-keyczar==0.71b

RUN ["/bin/bash", "-c", "source ansible/hacking/env-setup"]

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN mkdir /root/.ssh/

ADD docker/.ssh/* /root/.ssh/

RUN chmod 600 /root/.ssh/id_rsa*

CMD ["/bin/bash", "-c", "/obm-deploy/docker/run.sh"]
