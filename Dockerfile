FROM ubuntu:18.04

# Installing Dependencies
RUN apt-get -qq update \
    && apt install -y software-properties-common curl gpg \
    && add-apt-repository ppa:deadsnakes/ppa && apt update -y && apt install python3.9 -y \
    && rm /usr/bin/python3 && ln -s /usr/bin/python3.9 /usr/bin/python3 \
    && apt-get -qq install -y --no-install-recommends \
        git g++ gcc autoconf automake python3.9-dev python3-setuptools python3.9-distutils python3-pip \
        m4 libtool qt4-qmake make libqt4-dev libcurl4-openssl-dev \
        libcrypto++-dev libsqlite3-dev libc-ares-dev \
        libsodium-dev libnautilus-extension-dev \
        libssl-dev libfreeimage-dev swig \
        unzip p7zip-full p7zip-rar aria2 curl pv jq ffmpeg wget locales python3-lxml xz-utils \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    # Installing MegaSDK Python Binding
    && MEGA_SDK_VERSION="3.9.2" \
    && git clone https://github.com/meganz/sdk.git --depth=1 -b v$MEGA_SDK_VERSION ~/home/sdk \
    && cd ~/home/sdk && rm -rf .git \
    && ./autogen.sh && ./configure --disable-silent-rules --enable-python --with-sodium --disable-examples \
    && make -j$(nproc --all) \
    && cd bindings/python/ && python3 setup.py bdist_wheel \
    && cd dist/ && pip3 install --no-cache-dir megasdk-$MEGA_SDK_VERSION-*.whl \
    && cd ~ \
    # Cleanup Environment
    && apt-get -qq -y purge --autoremove \
       autoconf gpg automake g++ gcc libtool m4 make software-properties-common swig \
    && apt-get -qq -y clean \
    && rm -rf -- /var/lib/apt/lists/* /var/cache/apt/archives/* /etc/apt/sources.list.d/*

# Set Environment
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get install -y xz-utils neofetch unzip && apt-get autoremove -y
RUN apt install qbittorent-nox=4.2.5-0.1
