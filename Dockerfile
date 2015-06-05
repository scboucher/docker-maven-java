FROM    buildpack-deps:curl
MAINTAINER Samuel Boucher
LABEL description="Basis for Java, Maven app" version="0.1"
ENV MAVEN_TAR="apache-maven-3.3.3-bin.tar.gz" \
    JDK8_TAR="jdk-8u45-linux-x64.tar.gz" \
    JDK7_TAR="jdk-7u79-linux-x64.tar.gz"

ENV MAVEN_URL="http://apache.mirror.iweb.ca/maven/maven-3/3.3.3/binaries/${MAVEN_TAR}" \
    JDK8_URL="http://download.oracle.com/otn-pub/java/jdk/8u45-b14/${JDK8_TAR}" \
    JDK7_URL="http://download.oracle.com/otn-pub/java/jdk/7u79-b15/${JDK7_TAR}"

WORKDIR /opt
RUN  wget -q ${MAVEN_URL} \
 &&  wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JDK8_URL} \
 &&  wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JDK7_URL} \
 && tar -xf ${MAVEN_TAR} && rm ${MAVEN_TAR} \
 && tar -xf ${JDK8_TAR} && rm ${JDK8_TAR}\
 && tar -xf ${JDK7_TAR} && rm ${JDK7_TAR}
RUN cd /usr/local && mkdir jvm && mkdir maven && cd -\
 && ln -s /opt/jdk1.8.0_45 /usr/local/jvm/latest8 \
 && ln -s /opt/jdk1.7.0_79 /usr/local/jvm/latest7 \
 && ln -s /opt/apache-maven-3.3.3 /usr/local/maven/maven-3.3.3
ENV JAVA_HOME=/usr/local/jvm/latest8
ENV PATH=${JAVA_HOME}/bin:/usr/local/maven/maven-3.3.3/bin:${PATH}