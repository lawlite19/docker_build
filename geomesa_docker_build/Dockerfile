FROM alpine:latest
LABEL author="lawlite" email="849451478@qq.com"
RUN echo -e http://mirrors.ustc.edu.cn/alpine/latest-stable/main/ > /etc/apk/repositories && \
    echo -e http://mirrors.ustc.edu.cn/alpine/latest-stable/community/ >> /etc/apk/repositories && \ 
    set -eux && \
    apk add --no-cache bash openjdk8-jre-base

ARG GEOMESA_HBASE_VERSION=2.12-3.3.0

# hadoop-3.2.2
COPY hadoop-3.2.2 /opt/hadoop-3.2.2
# hbase-2.2
COPY hbase-2.2 /opt/hbase-2.2
# geomesa-hbase
COPY geomesa-hbase_${GEOMESA_HBASE_VERSION} /opt/geomesa-hbase_${GEOMESA_HBASE_VERSION}

# set env
ENV JAVA_HOME=/usr/
ENV HADOOP_HOME=/opt/hadoop-3.2.2
ENV HBASE_HOME=/opt/hbase-2.2
ENV GEOMESA_HBASE_HOME=/opt/geomesa-hbase_${GEOMESA_HBASE_VERSION}
ENV PATH $PATH:${GEOMESA_HBASE_HOME}/bin:${HADOOP_HOME}/bin:${HBASE_HOME}/bin

# Needed for HBase 2.0+ hbase-shell
# asciidoctor solves 'NotImplementedError: fstat unimplemented unsupported or native support failed to load'
RUN bash -c ' \
    set -euxo pipefail && \
    echo "http://mirrors.ustc.edu.cn/alpine/edge/community/" >> /etc/apk/repositories && \
    apk add --no-cache jruby jruby-irb asciidoctor && \
    echo exit | hbase shell \
    # jruby-maven jruby-minitest jruby-rdoc jruby-rake jruby-testunit && \
    '

COPY entrypoint.sh /
EXPOSE 1233
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]







