FROM ubuntu:trusty
MAINTAINER Radoslaw Frackiewicz <frodoslaw@gmail.com>

USER root

# Update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install curl -y

# Setup User "worker"
RUN useradd --home /home/worker -M worker -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash
RUN mkdir /home/worker
RUN chown worker:worker /home/worker
RUN adduser worker sudo
RUN echo 'worker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER worker

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && curl -sSL https://get.rvm.io | bash -s stable \
    && /bin/bash -l -c 'source ~/.rvm/scripts/rvm'

# Install Ruby
ENV DEFAULT_RUBY 2.3.0
ENV RUBIES 2.1.8 2.3.0 2.4.0

RUN /bin/bash -l -c 'rvm requirements'
RUN for RUBY in $RUBIES; do /bin/bash -l -c rvm install $RUBY; done
RUN /bin/bash -l -c 'rvm use $RUBY_VERSION --default'

# Install Bundler
RUN /bin/bash -l -c 'gem install bundler --no-doc --no-ri'
