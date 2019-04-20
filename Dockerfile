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
    apt-transport-https

RUN echo "deb https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EA0A9C3F273FCD8

RUN /usr/bin/apt-get update -yq && /usr/bin/apt-get install -yq \
    docker-ce \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip

RUN pip3 install docker openshift pyroute2

COPY configs/crohdad_start.sh /usr/bin/crohdad_start.sh

COPY configs/crohdad.py /root/crohdad.py

ENTRYPOINT ["/usr/bin/crohdad_start.sh"]
