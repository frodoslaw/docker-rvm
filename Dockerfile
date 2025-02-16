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

# Install RVM (Ruby Version Manager)
RUN curl -sSL https://get.rvm.io | bash -s stable

# Set RVM environment for all users
RUN echo 'source /etc/profile.d/rvm.sh' >> /etc/bash.bashrc

# Install multiple Ruby versions
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && \
    for version in 2.7.8 3.0.6 3.1.4; do \
        rvm install $version; \
    done && \
    rvm use 3.1.4 --default"

# Verify installation
RUN /bin/bash -c "source /etc/profile.d/rvm.sh && rvm list"

CMD ["/bin/bash"]
