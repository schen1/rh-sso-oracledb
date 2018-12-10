# rh-sso-oracledb
Deploy RH SSO with a template backed by external Oracle database

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
$ oc policy add-role-to-user view  -n $ns
```

```bash
$ oc process sso72-oracle \
-p IMAGE=quay.io/xyz:latest \
-p ORACLE_SERVICE_NAME=XXXXX  \
-p ORACLE_USERNAME=XXXXX \
-p ORACLE_PASSWORD=XXXXX \
-p ORACLE_DATABASE=XXXXX \
-p ORACLE_SERVICE_HOST=service-db.ocp-sso.svc \
-p ORACLE_SERVICE_HOST_2=service-db2.ocp-sso.svc  \
-p HOSTNAME_HTTPS=sso.example.com \
-p HOSTNAME_HTTP=nonsecure-sso.example.com \
-p OPENSHIFT_KUBE_PING_NAMESPACE=$ns \
-p SSO_TRUSTSTORE=truststore.jks \
-p SSO_TRUSTSTORE_PASSWORD=XXXXX \
-p SSO_ADMIN_PASSWORD=XXXXX \
-p SSO_ADMIN_USERNAME=XXXXX | oc create -f - -n $ns
```

# References
https://access.redhat.com/solutions/3402171

https://github.com/jboss-container-images/redhat-sso-7-openshift-image/tree/sso72-dev/templates

https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html-single/red_hat_jboss_enterprise_application_platform_for_openshift_online/#reference_clustering
