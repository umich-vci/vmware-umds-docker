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

The image directly runs the vmware-umds command and by default you will be shown the output of `--help`
for that command. Mounting a volume at /var/lib/vmware-umds is necessary to make the content you have
downloaded persist.

You can inject your download key to the configuration by setting the environment variable DOWNLOAD_TOKEN.
```
docker run --volume vmware-umds:/var/lib/vmware-umds --rm -it -e DOWNLOAD_TOKEN=yourTokenHere vmware-umds:8.0.3
```

It is also possible to bind mount `downloadConfig.xml` if you need to make additional adjustments to it (such as disabling an ESXi version). If you bind mount an empty file, the default config will be copied over.  You can still set `DOWNLOAD_TOKEN` if you so chose or you can manually edit the file with your token after the default has been copied.
```
docker run --volume repodata:/var/lib/vmware-umds --mount type=bind,src=/my/downloadConfig.xml,dst=/usr/local/vmware-umds/bin/downloadConfig.xml --rm -it vmware-umds:8.0.3
```

If you have your config how you want it and you want to download content (the `-D` argument to vmware-umds), you would run something like:
```
docker run --volume repodata:/var/lib/vmware-umds --mount type=bind,src=/my/downloadConfig.xml,dst=/usr/local/vmware-umds/bin/downloadConfig.xml --rm -it vmware-umds:8.0.3 -D
```
