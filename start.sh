#!/bin/bash

sed -i "s/REPLACETOKENHERE/${DOWNLOAD_TOKEN}/g" /usr/local/vmware-umds/bin/downloadConfig.xml
export PATH=$PATH:/usr/local/vmware-umds/bin
/bin/bash
