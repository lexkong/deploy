#!/bin/bash

> /tmp/CheckKey.log

#Check Host
[ "$(uname -r)" != "$host_kernel" -a "$host_kernel" != "" ] && echo "ERROR: host_kernel -> $(uname -r) != $host_kernel" >> /tmp/CheckKey.log

[ "$(eval cat /etc/redhat-release|awk "/$host_release/{print "1"}")" != "1" -a "$host_release" != "" ] && 
echo "ERROR: host_release -> $(cat /etc/redhat-release) != $host_release" >> /tmp/CheckKey.log

[ "$(eval cat /etc/redhat-release|awk "/$host_release/{print "1"}")" != "1" -a "$host_release" != "" ] && 
echo "ERROR: host_release -> $(cat /etc/redhat-release) != $host_release" >> /tmp/CheckKey.log

[ "$(uname -m)" != "$host_arch" -a "$host_arch" != "" ] && echo "ERROR: host_arch -> $(uname -m) != $host_arch" >> /tmp/CheckKey.log

#Check Guest (use libguestfs)

#Check Xen
[ "$(rpm -qa|egrep ^xen-[0-9]|sed 's/xen-//g')" != "$xen_version" -a "$xen_version" != "" ] && 
echo "ERROR: xen_version -> $(rpm -qa|egrep ^xen-[0-9]|sed 's/xen-//g') != $xen_version" >> /tmp/CheckKey.log

#Check Other

if [ -s "/tmp/CheckKey.log" ];then
    cat /tmp/CheckKey.log
else
    echo "No error!"
fi


