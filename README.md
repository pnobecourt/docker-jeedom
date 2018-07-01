# jeedom

This is a Debian based Jeedom Docker image.

Create container :

    docker run -d \
               --init \
               --restart always \
               --name jeedom \
               --hostname jeedom \
               -p 22:22/tcp \
               -p 80:80/tcp \
               -p 443:443/tcp \
               -v /etc/timezone:/etc/timezone:ro \
               -v /etc/localtime:/etc/localtime:ro \
               -v /path/to/your/jeedom/volume:/var/www/html:rw \
               -e "PUID=<your-uid>" \
               -e "PGID=<your-gid>" \
               -e "SHELL_ROOT_PASSWORD=<your-pwd>" \
               -e "SSH_PORT=<your-ssh-port>" \
               -e "APACHE_PORT=<your-apache-port>" \
               -e "MYSQL_HOST=<ip-or-hostname-of-your-mysql-host>" \
               -e "MYSQL_ROOT_PASSWD=<your-MySQL-root-pwd>" \
               -e "MYSQL_JEEDOM_PASSWD=<your-MySQL-jeedom-pwd>" \
               -e "MODE_HOST=<0,1> \
               barbak/jeedom

Or docker-compose :

    version: "3.6"
    services:
        # Jeedom
        jeedom:
            container_name: jeedom
            hostname: jeedom
            image: barbak/jeedom
            depends_on:
                - mysql
            restart: always
            ports:
                - "22:22/tcp"
                - "80:80/tcp"
                - "443:443/tcp"
            links:
                - mysql:db
            volumes:
                - /etc/timezone:/etc/timezone:ro
                - /etc/localtime:/etc/localtime:ro
                - /path/to/your/jeedom/volume:/var/www/html
            environment:
                - PUID=<your-uid>
                - PGID=<your-gid>
                - SHELL_ROOT_PASSWORD=<your-pwd>
                - SSH_PORT=<your-ssh-port>
                - APACHE_PORT=<your-apache-port>
                - MYSQL_HOST=<ip-or-hostname-of-your-mysql-host>
                - MYSQL_ROOT_PASSWD=<your-MySQL-root-pwd>
                - MYSQL_JEEDOM_PASSWD=<your-MySQL-jeedom-pwd>
                - MODE_HOST=<0,1>
                
The web interface runs on port 80.

List of exposed ports : 22/tcp 80/tcp 443/tcp
