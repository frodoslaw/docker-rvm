FROM ubuntu:trusty
MAINTAINER Radoslaw Frackiewicz <frodoslaw@gmail.com>

# Update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c 'source ~/.rvm/scripts/rvm'

ENV RUBY_VERSION 2.3.0

# Install Ruby
RUN /bin/bash -l -c 'rvm requirements'
RUN /bin/bash -l -c 'rvm install $RUBY_VERSION'
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'

RUN gem install bundler
