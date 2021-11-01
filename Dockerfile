FROM snyk/ubuntu

ARG version

USER root
ADD run.sh /run.sh
ADD https://github.com/snyk-tech-services/snyk-api-import/releases/download/v${version}/snyk-api-import-linux /snyk-api-import-linux
RUN chmod 755 /run.sh \
 && chmod a+x /snyk-api-import-linux \
 && chown 1000:1000 /snyk-api-import-linux

WORKDIR /home/node
USER node
CMD ["/run.sh"]