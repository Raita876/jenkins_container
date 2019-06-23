FROM jenkinsci/jenkins:latest

USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Golang Install
RUN wget https://storage.googleapis.com/golang/go1.12.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
RUN chown jenkins:jenkins /usr/local/go

USER jenkin 
ENV PATH $PATH:/usr/local/go/bin 

COPY ./ssh_config /var/jenkins_home/.ssh/config

# Docker Install and Setting
USER root

RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

RUN apt-get update
RUN apt-get install -y docker-ce vim

RUN gpasswd -a jenkins docker

RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
