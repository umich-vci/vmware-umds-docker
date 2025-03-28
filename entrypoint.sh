#!/bin/bash

if [ ! -z "${DOWNLOAD_TOKEN}" ]; then
    # Inject the token into the downloadConfig.xml this way in case it is a bind mount
    sed "s/REPLACETOKENHERE/${DOWNLOAD_TOKEN}/g" /usr/local/vmware-umds/bin/downloadConfig.xml > /usr/local/vmware-umds/bin/downloadConfig.xml.temp
    cat /usr/local/vmware-umds/bin/downloadConfig.xml.temp > /usr/local/vmware-umds/bin/downloadConfig.xml
    
    sed -i "s/REPLACETOKENHERE/${DOWNLOAD_TOKEN}/g" /usr/local/vmware-umds/bin/downloadConfig.xml.tmpl
fi

if [ ! -s /usr/local/vmware-umds/bin/downloadConfig.xml ]; then
  cp /usr/local/vmware-umds/bin/downloadConfig.xml.tmpl /usr/local/vmware-umds/bin/downloadConfig.xml
fi

/usr/local/vmware-umds/bin/vmware-umds $@
