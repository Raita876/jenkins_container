FROM jenkinsci/jenkins:latest

USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# Golang Install
RUN wget https://storage.googleapis.com/golang/go1.12.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz
RUN chown jenkins:jenkins /usr/local/go

USER jenkins 
ENV PATH $PATH:/usr/local/go/bin 




