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
