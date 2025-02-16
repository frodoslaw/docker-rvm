FROM ubuntu:20.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install curl gnupg -y
    
# Download and import GPG keys required for RVM
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB || \
    (curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -)

# Download RVM installer script
RUN curl -sSL https://get.rvm.io -o rvm-installer

# Install RVM
RUN bash rvm-installer

# Source RVM scripts
RUN echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc

# Reload shell for RVM
SHELL ["/bin/bash", "-l", "-c"]

RUN rvm get stable --autolibs=enable

RUN usermod -a -G rvm root

RUN rvm --version

RUN for version in 3.0.1 3.1.0 3.2.0 3.3.0 3.4.0 3.4.2; do \
    rvm install ruby-"$version"; \
    done

RUN rvm --default use ruby-3.4.2
