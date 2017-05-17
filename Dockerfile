FROM java:7-jdk-alpine

RUN apk add --no-cache wget
RUN apk add --no-cache bash

RUN mkdir /opt
RUN wget -q http://archive.apache.org/dist/hbase/hbase-0.94.22/hbase-0.94.22.tar.gz -O /opt/hbase-0.94.22.tar.gz && cd /opt && tar xfvz hbase-0.94.22.tar.gz && rm hbase-0.94.22.tar.gz
RUN ln -s /opt/hbase-0.94.22 /opt/hbase
RUN /opt/hbase/bin/hbase-config.sh

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD create_tables.txt /create_tables.txt
ADD start-pseudo-distributed.sh /opt/hbase/bin/start-pseudo-distributed.sh

# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh
