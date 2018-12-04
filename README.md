# rh-sso-oracledb
Deploy RH SSO with a template for accessing external Oracle database

# Prerequisites
Have the external Openshift service configured to the Oracle DB.
Extend the current Red Hat SSO image by adding the Oracle JDBC to the /extensions folder.
If necessary, create the truststore to trust your own certificates (in this repository, this is stored in a secret named sso-ssl-secret).

# Description
This repository contains the template to deploy RH SSO for accessing external Oracle database. To do so, it calls a script which is mounted under /extensions/scripts. This script will configure properly the standalone-openshift.xml file contained in the image to add the datasource. It also adds your own truststore.

# Commands
```bash
$ export ns=ocp-sso
```
```bash
$ oc create -f template.yaml -n $ns
```
```bash
$ oc process sso72-oracle \
-p ORACLE_SERVICE_NAME=XXXXX  \
-p ORACLE_USERNAME=XXXXX \
-p ORACLE_PASSWORD=XXXXX \
-o ORACLE_DATABASE=XXXXX \
-p ORACLE_SERVICE_HOST=service-db.ocp-sso.svc \
-p ORACLE_SERVICE_HOST_2=service-db2.ocp-sso.svc  \
-p HOSTNAME_HTTPS=sso.example.com \
-p HOSTNAME_HTTP=sso.example.com \
-p SSO_TRUSTSTORE_DIR=/etc/sso-secret-volume \
-p SSO_TRUSTSTORE=truststore.jks \
-p SSO_TRUSTSTORE_PASSWORD=XXXXX \
-p SSO_ADMIN_PASSWORD=XXXXX \
-p SSO_ADMIN_USERNAME=XXXXX | oc create -f - -n $ns
```

# References
https://access.redhat.com/solutions/3402171

https://github.com/jboss-container-images/redhat-sso-7-openshift-image/tree/sso72-dev/templates
