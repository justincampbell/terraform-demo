#!/bin/bash -ex

yum install -y httpd

INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id/)
INSTANCE_TYPE=$(curl http://169.254.169.254/latest/meta-data/instance-type/)
IMAGE_ID=$(curl http://169.254.169.254/latest/meta-data/ami-id/)

echo "Hello from ${INSTANCE_ID} (${INSTANCE_TYPE} built from ${IMAGE_ID})" > /var/www/html/index.html

service httpd start
chkconfig --level 345 httpd on
