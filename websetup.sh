#!/bin/bash
WEBURL="https://www.tooplate.com/zip-templates/2137_barista_cafe.zip"
WEBNAME="2137_barista_cafe"
DOWNLOADPATH="/tmp/webfiles"
WEBPATH="/var/www/html"
# Check OS
INSTALL_PGK="yum"
PACKAGE="httpd unzip wget"
SVC="httpd"

yum --help > /dev/null
if [ $? -eq 0 ]
then
    echo "Centos Setup"
else
    echo "Ubuntu setup"
    INSTALL_PGK="apt"
    PACKAGE="apache2 unzip wget"
    SVC="apache2"
fi

# Install package
echo "############################################"
echo "INSTALL PACKAGE"
sudo $INSTALL_PGK install $PACKAGE -y
echo
# Start http service
echo "############################################"
echo "START SERVICE"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo
# Download web template
echo "############################################"
echo "Download and unzip web files"
sudo mkdir -p $DOWNLOADPATH
cd $DOWNLOADPATH
sudo wget $WEBURL
echo "Unzip file"
sudo unzip $WEBNAME.zip
echo "Copy file"
sudo cp -r $WEBNAME/* $WEBPATH
echo
# restart web server
echo "############################################"
echo "RESTART SERVICE"
sudo systemctl restart $SVC
rm -rf /tmp/webfiles
