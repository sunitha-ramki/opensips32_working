FROM debian:bullseye
LABEL maintainer="Razvan Crainea <razvan@opensips.org>"

USER root

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ARG OPENSIPS_VERSION=3.3
ARG OPENSIPS_BUILD=releases

#install basic components
RUN apt -y update -qq && apt -y install apt-utils gnupg2 ca-certificates curl vim git rsyslog procps wget unzip default-mysql-client lsof iputils-ping

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf 
RUN sed -i -e '$aLocal0.*                      -/var/log/opensips.log' /etc/rsyslog.conf
RUN /etc/init.d/rsyslog restart
RUN touch /var/log/opensips.log

#RUN mkfifo /tmp/opensips_fifo

#add keyserver, repository
#RUN apt-key adv --fetch-keys https://apt.opensips.org/pubkey.gpg
RUN curl https://apt.opensips.org/opensips-org.gpg -o /usr/share/keyrings/opensips-org.gpg
#RUN echo "deb https://apt.opensips.org buster ${OPENSIPS_VERSION}-${OPENSIPS_BUILD}" >/etc/apt/sources.list.d/opensips.list
RUN echo "deb [signed-by=/usr/share/keyrings/opensips-org.gpg] https://apt.opensips.org bullseye 3.3-releases" >/etc/apt/sources.list.d/opensips.list
#RUN echo "deb [signed-by=/usr/share/keyrings/opensips-org.gpg] https://apt.opensips.org bullseye cli-nightly" >/etc/apt/sources.list.d/opensips-cli.list

RUN apt -y update -qq && apt -y install opensips 
RUN apt -y update -qq && apt -y install opensips-mysql-module
#RUN apt -y update -qq && apt -y install opensips-cli

RUN apt -y update -qq && apt -y install python3 python3-pip python3-dev gcc default-libmysqlclient-dev python3-mysqldb python3-sqlalchemy python3-sqlalchemy-utils python3-openssl

RUN git clone https://github.com/opensips/opensips-cli ~/src/opensips-cli
#RUN cd ~/src/opensips-cli
#RUN python3 setup.py install clean


RUN touch /root/.opensips-cli.cfg

RUN echo '[default]\n\
log_level: DEBUG\n\
prompt_name: opensips-cli\n\
prompt_intro: Welcome to OpenSIPS Command Line Interface!\n\
prompt_emptyline_repeat_cmd: False\n\
history_file: ~/.opensips-cli.history\n\
history_file_size: 1000\n\
output_type: pretty-print\n\
database_modules: ALL\n\
database_name: opensips\n\
database_admin_url: mysql://root@192.168.0.103:6606\n\
database_url: mysql://opensips:opensipsrw@192.168.0.103:6606' >> /root/.opensips-cli.cfg

#RUN sed -i '/^mpath=*/a \n\nloadmodule "event_stream.so"' /etc/opensips/opensips.cfg
#RUN ["/bin/bash","-c","'sed -i \'/^mpath=*/a \n\nloadmodule \"event_stream.so\"\' /etc/opensips/opensips.cfg'"]

#RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/^\(socket\|listen\)=udp.*5060/\1=udp:eth0:5060/g" /etc/opensips/opensips.cfg

EXPOSE 5060/udp

ENTRYPOINT ["/usr/sbin/opensips", "-FE"]
