#!/bin/bash

set -e

sudo dnf update -y
sudo dnf install -y java-17-amazon-corretto wget

export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
export PATH=$JAVA_HOME/bin:$PATH

TOMCAT_VERSION="9.0.118"
TOMCAT_URL="https://downloads.apache.org/tomcat/tomcat-9/v9.0.118/bin/apache-tomcat-9.0.118.tar.gz"
TOMCAT_HOME="$HOME/tom"

wget -O tomcat.tar.gz "$TOMCAT_URL"

rm -rf "$TOMCAT_HOME"

tar -xzf tomcat.tar.gz
rm -f tomcat.tar.gz

mv apache-tomcat-${TOMCAT_VERSION} "$TOMCAT_HOME"

rm -f "$TOMCAT_HOME/conf/server.xml"
rm -f "$TOMCAT_HOME/conf/tomcat-users.xml"
rm -f "$TOMCAT_HOME/webapps/manager/META-INF/context.xml"

cp -f ./server.xml "$TOMCAT_HOME/conf/server.xml"
cp -f ./tomcat-users.xml "$TOMCAT_HOME/conf/tomcat-users.xml"
cp -f ./context.xml "$TOMCAT_HOME/webapps/manager/META-INF/context.xml"

chmod +x "$TOMCAT_HOME"/bin/*.sh

"$TOMCAT_HOME/bin/startup.sh"
