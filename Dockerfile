FROM redhat-sso-7/sso72-openshift

USER root

## Add Oracle JAR to /extensions directory
ARG FILE_NAME=oracle-driver-ojdbc-12.1.0.2.jar
RUN mkdir /extensions && curl -o /extensions/${FILE_NAME}  https://example.com/${FILE_NAME}

USER jboss
