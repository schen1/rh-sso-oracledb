FROM redhat-sso-7/sso74-openshift

COPY actions.cli /opt/eap/extensions/
COPY postconfigure.sh /opt/eap/extensions/
ARG FILE_NAME=oracle-driver-ojdbc-12.1.0.2.jar

USER root

## Add Oracle JAR to /extensions directory
RUN mkdir /extensions && curl -o /opt/eap/${FILE_NAME}  https://example.com/${FILE_NAME} && \
    chmod 774 /opt/eap/extensions/*.sh

USER jboss

CMD ["/opt/eap/bin/openshift-launch.sh"]