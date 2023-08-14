#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <guacamole_version>"
  exit 1
fi

version=$1

if [ ! -f "https://dlcdn.apache.org/guacamole/${version}/source/guacamole-server-${version}.tar.gz" ]; then
  echo "Guacamole version ${version} not found"
  exit 1
fi

# Install dependencies
sudo apt update
sudo apt install -y gcc vim curl wget g++ libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev build-essential libpango1.0-dev libssh2-1-dev libvncserver-dev libtelnet-dev freerdp2-dev libwebsockets-dev libssl-dev libvorbis-dev libwebp-dev tomcat9 tomcat9-admin tomcat9-user

# Get Guacamole server release
wget https://dlcdn.apache.org/guacamole/${version}/source/guacamole-server-${version}.tar.gz
tar zxf guacamole-server-${version}.tar.gz

# Compile and install Guacamole server
cd guacamole-server-${version}/
./configure
make
sudo make install
sudo ldconfig

# Get Guacamole UI war file
cd /var/lib/tomcat9/
sudo wget https://dlcdn.apache.org/guacamole/${version}/binary/guacamole-${version}.war
sudo mv guacamole-${version}.war webapps/guacamole.war

# Configure Guacamole 
sudo mkdir /etc/guacamole
sudo mkdir /usr/share/tomcat9/.guacamole

cat <<IFS > /etc/guacamole/guacamole.properties
guacd-hostname: localhost
guacd-port: 4822
user-mapping: /etc/guacamole/user-mapping.xml
auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
basic-user-mapping: /etc/guacamole/user-mapping.xml
IFS

cat <<IFS > /etc/guacamole/user-mapping.xml
<user-mapping>

  <authorize
    username="guacadmin"
    password="guacadmin">

    <connection name="Localhost">
      <protocol>vnc</protocol>
      <param name="hostname">localhost</param>
      <param name="port">5901</param>
      <param name="password">vncpassword</param>
    </connection>

  </authorize>

</user-mapping>
IFS

sudo ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat9/.guacamole/

sudo chmod 600 /etc/guacamole/user-mapping.xml
sudo chown tomcat:tomcat /etc/guacamole/user-mapping.xml
