FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F93C028C093BFBA2 && \
     echo 'deb http://download.bareos.org/bareos/release/latest/Debian_8.0 /' > /etc/apt/sources.list.d/bareos.list

COPY dbconfig/bareos-database-common.conf /etc/dbconfig-common/

RUN  apt-get update && \
     apt-get install -y bareos-director \
       patch && \
     rm -rf /var/lib/apt/lists/*

COPY patch/01-fix-shell-shift.patch /tmp/

RUN  cd /var/lib/dpkg/info/ && \
     patch -p1 < /tmp/01-fix-shell-shift.patch

CMD ["/bin/bash"]
