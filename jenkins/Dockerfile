FROM jenkins/jenkins:lts

USER root

# Install system dependencies: Python, pip, git, etc.
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    bash \
    curl \
    sudo

# Make `pip` and `python` point to Python 3
RUN [ -e /usr/bin/python ] || ln -s /usr/bin/python3 /usr/bin/python && \
    [ -e /usr/bin/pip ] || ln -s /usr/bin/pip3 /usr/bin/pip


# Install Jenkins plugins from plugins.txt
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER jenkins
