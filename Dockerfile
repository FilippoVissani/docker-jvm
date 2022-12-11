ARG JAVA_VERSION="17.0.5-amzn"
ARG SCALA_VERSION="3.2.1"
ARG KOTLIN_VERSION="1.7.21"
ARG GRADLE_VERSION="7.6"
ARG SBT_VERSION="1.8.0"
ARG MAVEN_VERSION="3.8.6"
ARG BASE_IMAGE_VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${BASE_IMAGE_VARIANT}
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    yes | sdk install java $JAVA_VERSION && \
    yes | sdk install scala $SCALA_VERSION && \
    yes | sdk install kotlin $KOTLIN_VERSION && \
    yes | sdk install gradle $GRADLE_VERSION && \
    yes | sdk install sbt $SBT_VERSION && \
    yes | sdk install maven $MAVEN_VERSION"
CMD /bin/bash