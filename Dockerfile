FROM ubuntu:20.04 AS base

ARG UMDS_VERSION

RUN --mount=type=bind,source=VMware-UMDS-${UMDS_VERSION}.tar.gz,target=/tmp/VMware-UMDS.tar.gz \
   apt update && apt upgrade -y && apt install -y psmisc && \
   tar xf /tmp/VMware-UMDS.tar.gz -C /tmp && \
   /tmp/vmware-umds-distrib/vmware-install.pl --default EULA_AGREED=yes && \
   sed -i 's/https:\/\/hostupdate.vmware.com\/software\/VUM\/PRODUCTION\/main\/vmw-depot-index.xml/https:\/\/dl.broadcom.com\/REPLACETOKENHERE\/PROD\/COMP\/ESX_HOST\/main\/vmw-depot-index.xml/' /usr/local/vmware-umds/bin/downloadConfig.xml && \
   sed -i 's/https:\/\/hostupdate.vmware.com\/software\/VUM\/PRODUCTION\/addon-main\/vmw-depot-index.xml/https:\/\/dl.broadcom.com\/REPLACETOKENHERE\/PROD\/COMP\/ESX_HOST\/addon-main\/vmw-depot-index.xml/' /usr/local/vmware-umds/bin/downloadConfig.xml && \
   sed -i 's/https:\/\/hostupdate.vmware.com\/software\/VUM\/PRODUCTION\/iovp-main\/vmw-depot-index.xml/https:\/\/dl.broadcom.com\/REPLACETOKENHERE\/PROD\/COMP\/ESX_HOST\/iovp-main\/vmw-depot-index.xml/' /usr/local/vmware-umds/bin/downloadConfig.xml && \
   sed -i 's/https:\/\/hostupdate.vmware.com\/software\/VUM\/PRODUCTION\/vmtools-main\/vmw-depot-index.xml/https:\/\/dl.broadcom.com\/REPLACETOKENHERE\/PROD\/COMP\/ESX_HOST\/vmtools-main\/vmw-depot-index.xml/' /usr/local/vmware-umds/bin/downloadConfig.xml

COPY start.sh /start.sh

CMD ["/start.sh"]
