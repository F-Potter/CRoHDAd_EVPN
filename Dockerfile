FROM ubuntu:bionic

LABEL maintainer="Anton Degtiarev <anton@cumulusnetworks.com>"
LABEL com.cumulusnetworks.version="2.0"
LABEL vendor="Cumulus Networks"
LABEL description="Now with support for Kubernetes and OpenShift!"

RUN apt-get update && apt-get -y install \
    iptables \
    iproute2 \
    python3 \
    python3-pip \
    apt-transport-https \
    curl \
    software-properties-common \
    ca-certificates \
    gnupg-agent 

RUN echo "deb https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8



#RUN echo "deb https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list \
#    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8

RUN /usr/bin/apt-get update -yq && /usr/bin/apt-get install -yq \
    docker-ce \
    && rm -rf /var/lib/apt/lists/*

#RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" > /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8

#RUN echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F76221572C52609D

#RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

#RUN apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'

#RUN apt-get update

#RUN apt-get -y install curl gpg gnupg2 docker.io software-properties-common

#RUN apt-get -y install docker-ce

RUN pip3 install --upgrade pip

RUN pip3 install docker openshift pyroute2

WORKDIR /home/cumulus/chp-k8s-crohdad/configs

COPY configs/crohdad_start.sh /usr/bin/crohdad_start.sh

COPY configs/crohdad.py /root/crohdad.py

ENTRYPOINT ["/usr/bin/crohdad_start.sh"]
