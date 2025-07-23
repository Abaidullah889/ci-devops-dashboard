FROM jenkins/jenkins:lts

USER root

# Install Python, pip, venv, git, etc.
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    bash \
    curl \
    sudo

# Optionally make python/pip symlinks
RUN [ -e /usr/bin/python ] || ln -s /usr/bin/python3 /usr/bin/python && \
    [ -e /usr/bin/pip ] || ln -s /usr/bin/pip3 /usr/bin/pip

# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER jenkins
