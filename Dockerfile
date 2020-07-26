# Build environment for ESOS

FROM ubuntu:latest

# Fix repositories
RUN sed -i 's/main$/main universe/' /etc/apt/sources.list; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y \
        build-essential \
        ccache \
        curl \
        git \
        autoconf \
        gawk \
        flex \
        bison \
        gcc-multilib \
        unzip \
        libtinfo-dev \
        libtool \
        lsscsi \
        kpartx \
        libxslt1-dev \
        groff \
        gettext \
        xsltproc \
        pkg-config \
        autopoint \
        zip \
        cpio \
        dosfstools \
        wget \
        rsync \
        python3 \
        gosu \
        sudo; \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY build.sh /usr/local/bin/build.sh

RUN chmod o+rx /usr/local/bin/*.sh

# Allow password-less 'sudo' for all users in group 'sudo'
RUN sed "s/^%sudo.*/%sudo\tALL=(ALL) NOPASSWD:ALL/g" -i /etc/sudoers && \
chmod a+s /usr/sbin/useradd /usr/sbin/groupadd /usr/sbin/gosu /usr/sbin/usermod

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/build.sh"]
