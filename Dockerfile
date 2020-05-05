FROM redhat-sso-7/sso74-openshift

COPY actions.cli /opt/eap/extensions/
COPY postconfigure.sh /opt/eap/extensions/
ENV ORACLE_DRIVER_FILE_NAME=ojdbc8-19.3.0.0.jar

USER root

## Add Oracle JAR to /extensions directory
RUN curl -o /opt/eap/extensions/${ORACLE_DRIVER_FILE_NAME}  https://example.com/${ORACLE_DRIVER_FILE_NAME} && \
    chmod 774 /opt/eap/extensions/*.sh

USER jboss

CMD ["/opt/eap/bin/openshift-launch.sh"]