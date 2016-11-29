# Build Oracle JDK 1.8 image

FROM centos:7.2.1511

MAINTAINER Yong Wang <yong.wang@thomsonreuters.com>

ENV VERSION 8
ENV UPDATE 60
ENV BUILD 27

ENV JAVA_HOME /usr/java/oracle-jdk-1.${VERSION}.0_${UPDATE}
ENV JRE_HOME ${JAVA_HOME}/jre

# Download Oracle JDK from official Oracle site and extract to 
RUN curl --silent --location --retry 3 \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/server-jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz \
    | tar xz -C /tmp && \
    mkdir -p /usr/java && mv /tmp/jdk1.${VERSION}.0_${UPDATE} "${JAVA_HOME}"

RUN update-alternatives --install "/usr/bin/java" "java" "${JRE_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JRE_HOME}/bin/java" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"
