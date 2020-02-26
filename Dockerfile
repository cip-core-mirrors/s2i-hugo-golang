FROM centos/s2i-base-centos7:latest

USER root

# Add golang package
RUN yum install -y centos-release-scl-rh epel-release && \
    yum-config-manager --enable centos-sclo-rh-testing && \
    INSTALL_PKGS="golang" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS

ENV NAME hugo
ENV HUGO_VERSION 0.64.0

RUN curl -fssL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" | tar -xz -C /usr/local/bin

COPY ./s2i/* $STI_SCRIPTS_PATH/
RUN chmod -R 755 $STI_SCRIPTS_PATH/
RUN chown -R 0:0 /opt/app-root/
RUN chmod -R 774 /opt/app-root/

USER 1001