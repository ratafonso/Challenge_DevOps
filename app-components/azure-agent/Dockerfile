FROM ubuntu:jammy
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    wget \
    lsb-release \
    software-properties-common \
    python3 \
    python3-venv \
    python3-pip \
    maven \
    openjdk-8-jdk \
    openjdk-17-jdk \
    docker
    

RUN python3 -m venv azure-cli-env
RUN pip install requests

# Update pip
RUN azure-cli-env/bin/python3 -m pip install --upgrade pip

# Install azure-cli
RUN azure-cli-env/bin/python3 -m pip install azure-cli

# Run any Azure CLI commands
RUN azure-cli-env/bin/az --version

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

RUN update-ca-certificates
WORKDIR /opt
RUN wget -q https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz ; tar zxf apache-maven-3.9.8-bin.tar.gz
WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]