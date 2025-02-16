# Use the latest Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN gpg2 --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# Install RVM (Ruby Version Manager)
RUN curl -sSL https://get.rvm.io -o rvm.sh
RUN cat rvm.sh | bash -s stable --rails

# Load RVM and install multiple Ruby versions
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && \
    rvm install 2.7.8 && \
    rvm install 3.0.6 && \
    rvm install 3.1.4 && \
    rvm use 3.1.4 --default"

# Set RVM environment for all users
RUN echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc

# Verify installation
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && rvm list"

CMD ["/bin/bash"]
