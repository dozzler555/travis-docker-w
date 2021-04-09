#This is a sample Image 
FROM ubuntu
MAINTAINER demousr@gmail.com
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends git cmake g++

# Cleanup
RUN  apt-get clean && \
  rm -rf /var/lib/apt

RUN apt-get update 
RUN apt-get install sudo -y
RUN sudo -E apt-get clean
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install aria2 -y
RUN apt-get install nano -y
RUN apt-get install git -y; git config --global color.ui false; git config --global user.name "Brock555"; git config --global user.email "77067332+Brock5555@users.noreply.github.com"
RUN wget https://raw.githubusercontent.com/Dazzler555/huiifzet/master/setup/android_build_env.sh
RUN chmod a+x android_build_env.sh; bash android_build_env.sh
RUN wget https://raw.githubusercontent.com/Dazzler555/huiifzet/master/setup/install_android_sdk.sh
RUN chmod a+x install_android_sdk.sh; bash install_android_sdk.sh
RUN chmod a+x install_android_sdk.sh; bash install_android_sdk.sh

COPY . .
CMD [“echo”,”Image created”,"/bin/bash/"] 
