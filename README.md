# Dockerfile for VMware vSphere Update Manager Download Service

## Build Instructions
Get the UMDS tar.gz from the vCenter Installer ISO of the version of vCenter you are using and
drop it alongside the Dockerfile. I have tested the following versions:
* VMware-UMDS-7.0.3.02200-14372979.tar.gz
* VMware-UMDS-8.0.3.00400-14373555.tar.gz

Then, build the image with something like this:
```
docker build --build-arg UMDS_VERSION=8.0.3.00400-14373555 -t vmware-umds:8.0.3 .
```
or
```
docker build --build-arg UMDS_VERSION=7.0.3.02200-14372979  -t vmware-umds:7.0.3 .
```

If you are building on an ARM based Mac, you'll need to add `--platform linux/amd64` to the build command.

## Run Instructions

You can run the image with something like this:
```
docker run --volume vmware-umds:/var/lib/vmware-umds --rm -it -e DOWNLOAD_TOKEN=yourTokenHere vmware-umds:8.0.3
```
The startup script currently just edits `/usr/local/vmware-umds/bin/downloadConfig.xml` to inject your download token and then drops you into a shell. Mounting a volume at /var/lib/vmware-umds makes the content you have downloaded persist.
