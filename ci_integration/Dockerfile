FROM dart:3.0.2

ARG FLUTTER_VERSION

RUN apt-get update --quiet --yes
RUN apt-get install --quiet --yes \
    unzip \
    lcov \
    apt-utils

ENV DART_SDK=/usr/lib/dart

ENV PATH=/usr/lib/dart/bin:/root/fvm/default/bin:/root/.pub-cache/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN dart pub global activate fvm

RUN fvm install -s ${FLUTTER_VERSION}

RUN fvm global ${FLUTTER_VERSION}

RUN flutter pub global activate dart_code_metrics

RUN flutter pub global activate junitreport

RUN flutter doctor --android-licenses