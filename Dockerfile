FROM debian:stretch

MAINTAINER Stig Sandbeck Mathisen <ssm@fnord.no>

LABEL io.k8s.description="Platform for building and serving static website content" \
      io.openshift.s2i.scripts-url=image:///usr/local/share/s2i \
      io.openshift.expose-services="4000:http" \
      io.openshift.tags="builder,httpd"
 
# Install packages needed for building and serving a jekyll site
RUN apt-get update \
 && apt-get --no-install-recommends -y install \
    gettext \
    jekyll \
    libnss-wrapper \
    linkchecker \
    ruby-gsl \
    webfs \
 && apt-get clean \
 && find /var/lib/apt/lists -type f -delete

EXPOSE 4000

COPY .s2i/* /usr/local/share/s2i/

RUN install -o 0 -g 0 -m 0775 -d /srv/content
WORKDIR /srv/content
USER 1000
