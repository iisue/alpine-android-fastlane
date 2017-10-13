FROM anapsix/alpine-java:8_jdk
LABEL maintainer "IISUE <sklee@iisue.com>"

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="e.g. https://github.com/microscaling/microscaling"

ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"

ENV ANDROID_HOME "/android-sdk"
ENV ANDROID_COMPILE_SDK "26"
ENV ANDROID_BUILD_TOOLS "26.0.2"
ENV ANDROID_SDK_TOOLS "3859397"
ENV PATH "$PATH:${ANDROID_HOME}/platform-tools"

RUN apk update && \
    apk add --no-cache \
        git \
        bash \
        curl \
        wget \
        zip \
        unzip \
        ruby \
        ruby-rdoc \
        ruby-irb \
        ruby-dev \
        openssh \
        g++ \
        make \
    && gem install fastlane \
    && rm -rf /tmp/* /var/tmp/*

ADD https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip sdk-tools-linux.zip

RUN unzip sdk-tools-linux.zip -d ${ANDROID_HOME} && \
    rm sdk-tools-linux.zip && \
    echo y | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" "build-tools;${ANDROID_BUILD_TOOLS}"
