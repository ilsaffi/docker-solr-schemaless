# debian jessie based
FROM debian:jessie
# No frills here - openjdk7 and some small utils
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-7-jre-headless \
    unzip \
    wget \
    procps \
    lsof \
    curl \
    less && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV SOLR_VERSION 4.10.2
ENV SOLR solr-$SOLR_VERSION
RUN echo download solr $SOLR_VERSION
RUN  mkdir -p /opt && \
    curl -SL http://mirrors.ibiblio.org/apache/lucene/solr/$SOLR_VERSION/$SOLR.tgz -o $SOLR.tgz
RUN cat $SOLR.tgz | tar -xvzC /opt && \
    ln -s /opt/$SOLR /opt/solr

#####################################################################################
# configure solr as schemaless.

EXPOSE 8983

CMD ["/bin/bash", "-c", "/opt/solr/bin/solr -f"]
