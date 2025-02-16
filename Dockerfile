FROM ubuntu:24.04

USER root

# Update
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install curl -y \
    && apt-get install -y ruby ruby-dev

# Setup User "worker"
RUN useradd --home /home/worker -M worker -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash
RUN mkdir /home/worker
RUN chown worker:worker /home/worker
RUN adduser worker sudo
RUN echo 'worker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER worker

# Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | bash -s stable \
    && /bin/bash -l -c 'source ~/.rvm/scripts/rvm'

# Install Ruby
ENV DEFAULT_RUBY 2.4.0

RUN /bin/bash -l -c 'rvm requirements'
RUN /bin/bash -l -c "rvm install 2.0.0"
RUN /bin/bash -l -c "rvm install 2.1.0"
RUN /bin/bash -l -c "rvm install 2.1.8"
RUN /bin/bash -l -c "rvm install 2.2.0"
RUN /bin/bash -l -c "rvm install 2.3.0"
RUN /bin/bash -l -c "rvm install 2.4.0"
RUN /bin/bash -l -c "rvm install 2.5.0"
RUN /bin/bash -l -c 'rvm use $DEFAULT_RUBY --default'

# Install Bundler
RUN /bin/bash -l -c 'gem install bundler --no-doc --no-ri'
