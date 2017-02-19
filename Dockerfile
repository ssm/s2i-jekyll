FROM debian:stretch

MAINTAINER Stig Sandbeck Mathisen <ssm@fnord.no>

# Install packages needed for building and serving a jekyll site
RUN apt-get update \
 && apt-get --no-install-recommends -y install jekyll ruby-gsl webfs linkchecker \
 && apt-get clean \
 && find /var/lib/apt/lists -type f -delete

EXPOSE 8080

RUN install -o 0 -g 0 -m 0775 -d /srv/content
WORKDIR /srv/content
USER 1000
