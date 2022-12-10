FROM debian:bullseye-slim 

ARG JAVA_VERSION="17.0.5-amzn"
ARG SCALA_VERSION="3.2.1"
ARG KOTLIN_VERSION="1.7.21"
ARG GRADLE_VERSION="7.6"
ARG SBT_VERSION="1.8.0"
ARG MAVEN_VERSION="3.8.6"

# Defining default non-root user UID, GID, and name 
ARG USER_UID="1000"
ARG USER_GID="1000"
ARG USER_NAME="dev"

# Creating default non-user 
RUN groupadd -g $USER_GID $USER_NAME && \
	useradd -m -g $USER_GID -u $USER_UID $USER_NAME

# Installing basic packages 
RUN apt-get update && \
	apt-get install -y zip unzip curl git && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

# Switching to non-root user to install SDKMAN! 
USER $USER_UID:$USER_GID

WORKDIR /home/$USER_NAME

# Downloading SDKMAN! 
RUN curl -s "https://get.sdkman.io" | bash

# Installing Java and Maven, removing some unnecessary SDKMAN files 
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install scala $SCALA_VERSION && \
    yes | sdk install kotlin $KOTLIN_VERSION && \
    yes | sdk install gradle $GRADLE_VERSION && \
    yes | sdk install sbt $SBT_VERSION && \
    yes | sdk install maven $MAVEN_VERSION && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"
