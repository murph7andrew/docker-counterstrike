FROM ubuntu:18.04

#Define the steamcmd user
ENV USER admin
ENV USER_HOME /home/$USER

#Steamcmd metadata
ENV STEAMCMD_HOME $USER_HOME/steamcmd
ENV STEAMCMD_URL http://media.steampowered.com/client/steamcmd_linux.tar.gz

#Install steamcmds dependencies.Create admin user
RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc1 curl net-tools lib32stdc++6 locales \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -m $USER \
    && mkdir -p $STEAMCMD_HOME \
    && chown -R $USER:$USER $USER_HOME

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

USER $USER
WORKDIR $USER_HOME

#copy supporting files
COPY ./entrypoint.sh /usr/local/bin

VOLUME [ $USER_HOME ]

ENTRYPOINT [ "entrypoint.sh" ]