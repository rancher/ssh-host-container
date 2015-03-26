#!/bin/bash

export BASEDIR="/opt/ranchertest"
export USER_GROUP="ranchertest:ranchertest"


set_authorized_keys()
{
    echo ${SSH_KEY} >> ${BASEDIR}/.ssh/authorized_keys
    chmod 600 ${BASEDIR}/.ssh/authorized_keys
}

echo ${SSH_KEY}
set_authorized_keys
chown -R ${USER_GROUP} ${BASEDIR}

/usr/sbin/sshd -D
