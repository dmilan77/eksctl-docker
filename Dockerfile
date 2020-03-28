FROM python:3.7.7-alpine3.11 
RUN apk -v --update add \
        groff \
        curl \
        less \
        mailcap \
        bash \
        zip \
        openssl \
        && \
    pip install --upgrade awscli==1.18.27 && \
    pip install --upgrade  s3cmd==2.0.2  python-magic requests==2.23.0 argparse==1.4.0 && \
    pip install --upgrade boto3==1.12.27 && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*
VOLUME /root/.aws
VOLUME /project
WORKDIR /project
# https://github.com/weaveworks/eksctl/releases/download/0.16.0/eksctl_Linux_amd64.tar.gz
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/bin
RUN chmod 755 /usr/bin/eksctl
ENTRYPOINT ["bash"]

