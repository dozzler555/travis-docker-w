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
RUN git clone https://github.com/Dazzler555/huiifzet.git scripts
RUN cd scripts; sudo bash setup/android_build_env.sh; sudo bash setup/install_android_sdk.sh; sudo bash setup/install_android_sdk.sh
RUN git clone https://github.com/Jjtitdutitdtti7s5s/dum.git; cd dum; apt-get update; apt-get install python3-pip -y; bash setup.sh

COPY . .
CMD [“echo”,”Image created”,"/bin/bash/"] 
