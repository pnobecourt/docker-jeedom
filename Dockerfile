# Download base image
FROM barbak/debian-s6:latest

# Define the ARG variables
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

# Labels
LABEL org.label-schema.name="Jeedom" \
      org.label-schema.description="Debian based Jeedom Docker image" \
      org.label-schema.vendor="Paul NOBECOURT <paul.nobecourt@orange.fr>" \
      org.label-schema.url="https://github.com/pnobecourt/" \
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/pnobecourt/docker-jeedom" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0"

# Define the ENV variables
ENV JEEDOM_VOL=/var/www/html \
APACHE_PORT=80 \
SSH_PORT=22 \
MODE_HOST=0

# Jeedom installation
RUN echo "deb https://deb.nodesource.com/node_8.x stretch main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
    echo "deb http://www.deb-multimedia.org stretch main non-free" | tee -a /etc/apt/sources.list.d/debian-multimedia.list && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    apt-get update ; \
    apt-get install -y --allow-unauthenticated --no-install-recommends deb-multimedia-keyring && \
    apt-get install -y --no-install-recommends \
   	 	 	 	 	adduser \
	 	 	 	 	apache2 \
	 	 	 	 	apache2-utils \
	 	 	 	 	apt-utils \
	 	 	 	 	build-essential \
	 	 	 	 	ca-certificates \
	 	 	 	 	cron \
	 	 	 	 	curl \
	 	 	 	 	cutycapt \
	 	 	 	 	dh-python \
	 	 	 	 	dialog \
	 	 	 	 	dos2unix \
	 	 	 	 	duplicity \
	 	 	 	 	espeak \
	 	 	 	 	fail2ban \
	 	 	 	 	git \
	 	 	 	 	htop \
	 	 	 	 	iftop \
	 	 	 	 	iotop \
	 	 	 	 	iso-codes \
	 	 	 	 	javascript-common \
	 	 	 	 	libapache2-mod-php7.0 \
	 	 	 	 	libarchive-dev \
	 	 	 	 	libav-tools \
	 	 	 	 	libexpat1 \
	 	 	 	 	libjs-jquery \
	 	 	 	 	libjsoncpp-dev \
	 	 	 	 	libmpdec2 \
	 	 	 	 	libpcre3-dev \
	 	 	 	 	libpython3-stdlib \
	 	 	 	 	libsox-fmt-mp3 \
	 	 	 	 	libtinyxml-dev \
	 	 	 	 	libudev1 \
	 	 	 	 	libxml2 \
	 	 	 	 	locales \
	 	 	 	 	locate \
	 	 	 	 	logrotate \
	 	 	 	 	lsb-release \
	 	 	 	 	make \
	 	 	 	 	miniupnpc \
	 	 	 	 	mysql-client \
	 	 	 	 	mysql-common \
	 	 	 	 	nano \
	 	 	 	 	net-tools \
	 	 	 	 	nodejs \
	 	 	 	 	npm \
	 	 	 	 	ntp \
	 	 	 	 	ntpdate \
	 	 	 	 	openssh-server \
	 	 	 	 	ow-shell \
	 	 	 	 	php7.0 \
	 	 	 	 	php7.0-common \
	 	 	 	 	php7.0-curl \
	 	 	 	 	php7.0-dev \
	 	 	 	 	php7.0-gd \
	 	 	 	 	php7.0-imap \
	 	 	 	 	php7.0-json \
	 	 	 	 	php7.0-ldap \
	 	 	 	 	php7.0-mbstring \
	 	 	 	 	php7.0-mcrypt \
	 	 	 	 	php7.0-mysql \
	 	 	 	 	php7.0-opcache \
	 	 	 	 	php7.0-soap \
	 	 	 	 	php7.0-ssh2 \
	 	 	 	 	php7.0-xml \
	 	 	 	 	php7.0-xmlrpc \
	 	 	 	 	php7.0-zip \
	 	 	 	 	php-pear \
	 	 	 	 	python \
	 	 	 	 	python3 \
	 	 	 	 	python3-apt \
	 	 	 	 	python3-dbus \
	 	 	 	 	python3-gi \
	 	 	 	 	python3-minimal \
	 	 	 	 	python3-software-properties \
	 	 	 	 	python-apt-common \
	 	 	 	 	python-pip \
	 	 	 	 	python-serial \
	 	 	 	 	ruby \
	 	 	 	 	rubygems-integration \
	 	 	 	 	smbclient \
	 	 	 	 	software-properties-common \
	 	 	 	 	sox \
	 	 	 	 	ssl-cert \
	 	 	 	 	sudo \
	 	 	 	 	supervisor \
	 	 	 	 	systemd \
	 	 	 	 	tar \
	 	 	 	 	telnet \
	 	 	 	 	unattended-upgrades \
	 	 	 	 	unzip \
	 	 	 	 	usb-modeswitch \
	 	 	 	 	vim \
	 	 	 	 	wget \
	 	 	 	 	xauth \
	 	 	 	 	xvfb \
                    && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
           /tmp/* \
           /var/lib/apt/lists/* \
           /var/log/* \
           /var/tmp/* \
           && \
    curl -L -S https://github.com/jeedom/core/archive/stable.zip -o /tmp/jeedom_stable.zip && \
    mkdir -p /tmp/install_temp ${JEEDOM_VOL} && \
    unzip -qo /tmp/jeedom_stable.zip -d /tmp/install_temp && \
    cp -R /tmp/install_temp/core-*/* ${JEEDOM_VOL} && \
    cp -R /tmp/install_temp/core-*/.[^.]* ${JEEDOM_VOL} && \
    rm -rf /tmp/install_temp > /dev/null 2>&1 && \
    rm /tmp/jeedom_stable.zip && \
    rm /etc/motd && \
    rm /root/.bashrc
    
# Add files
ADD /root /

# Define Volumes
VOLUME [ "/etc","/var/www/html" ]

# Ports configuration
EXPOSE 22 80 443

# Entrypoint
ENTRYPOINT [ "/init" ]
