# Start from the official Jenkins LTS image
FROM jenkins/jenkins:lts

USER root

# Copy plugin list and install with Jenkins plugin CLI
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Install extra utilities
RUN apt-get update && apt-get install -y \
    git \
    bash \
    curl \
    sudo

USER jenkins
