FROM debian:stretch

MAINTAINER Stig Sandbeck Mathisen <ssm@fnord.no>

LABEL io.k8s.description="Platform for building and serving static website content" \
      io.openshift.s2i.scripts-url=image:///usr/local/share/s2i \
      io.openshift.expose-services="4000:http" \
      io.openshift.tags="builder,httpd"
 
COPY dpkg-excludes /etc/dpkg/dpkg.cfg.d/

# Install packages needed for building and serving a jekyll site
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -q -y --no-install-recommends install \
    gettext \
    jekyll \
    libnss-wrapper \
    linkchecker \
    ruby-gsl \
    webfs \
 && apt-get clean \
 && find /var/lib/apt/lists /var/cache -type f -delete

EXPOSE 4000

COPY .s2i/* /usr/local/share/s2i/
COPY passwd.template /srv

RUN install -o 0 -g 0 -m 0775 -d /srv/content
WORKDIR /srv/content
USER 1000
