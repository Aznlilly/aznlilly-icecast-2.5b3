# Icecast 2.5 Beta 3 Container

[Docker Hub Repo](https://hub.docker.com/r/aznlilly/icecast-2.5b3)

## Instructions

Bind mount error.log and access.log to /tmp/error.log and /tmp/access.log inside container.
Bind mount icecast.xml configuration file to /tmp/icecast.xml inside container.

Run container example:  
```
docker run -d --name icecast \
-p 8000:8000 \
-v "$(pwd)"/icecast.xml:/tmp/icecast.xml \
-v "$(pwd)"/access.log:/tmp/access.log:rw \
-v "$(pwd)"/error.log:/tmp/error.log:rw \
aznlilly/icecast-2.5b3:0.0.1
```

Example icecast.xml CHANGE PASSSWORDS!
```
<!-- This config file contains a minimal set of configurable parameters,
     and mostly just contains the things you need to change or are
     necessary to get Icecast working for most use cases.  We created
     this for those who got scared away from the rather large and heavily
     commented icecast.xml.dist file.
-->
<icecast>
    <limits>
        <sources>2</sources>
    </limits>
    <authentication>
        <source-password>changeme</source-password>
        <relay-password>changeme</relay-password>
        <admin-user>admin</admin-user>
        <admin-password>changeme</admin-password>
    </authentication>
    <yp-directory url="https://dir.xiph.org/cgi-bin/yp-cgi">
        <option name="timeout" value="15" />
    </yp-directory>
    <hostname>localhost</hostname>
    <listen-socket>
        <port>8000</port>
    </listen-socket>
    <paths>
            <logdir>/tmp</logdir>
            <webroot>/tmp/icecast/web</webroot>
            <adminroot>/tmp/icecast/admin</adminroot>
        <alias source="/" destination="/status.xsl"/>
    </paths>
    <logging>
            <accesslog>access.log</accesslog>
            <errorlog>error.log</errorlog>
        <loglevel>information</loglevel> <!-- "debug", "information", "warning", or "error" -->
    </logging>
    <http-headers>
        <header type="cors" name="Access-Control-Allow-Origin" />
        <header type="cors" name="Access-Control-Allow-Headers" />
        <header type="cors" name="Access-Control-Expose-Headers" />
    </http-headers>
    <security>
    <chroot>0</chroot>
    <changeowner>
        <user>icecast</user>
        <group>icecast</group>
    </changeowner>
</security>
</icecast>

```
