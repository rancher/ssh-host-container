FROM rancher/dind:v0.2.0

MAINTAINER Sangeetha Hariharan "<sangeetha@rancher.com>"

RUN apt-get update && apt-get -y install git openssh-server

RUN sed -i 's/PermitRootLogin\ without-password/PermitRootLogin\ no/' /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd

RUN useradd -m -d /opt/ranchertest ranchertest
RUN cd /opt/ranchertest && mkdir .ssh && chmod 700 .ssh && chown -R ranchertest:ranchertest .ssh
RUN sudo adduser ranchertest sudo
RUN echo "ranchertest ALL=NOPASSWD: ALL">>/etc/sudoers
RUN echo "PasswordAuthentication no">> /etc/ssh/sshd_config

COPY ./run.sh /scripts/run.sh
RUN chmod 777 /scripts/run.sh

EXPOSE 22

ENTRYPOINT [ "/scripts/run.sh" ]

