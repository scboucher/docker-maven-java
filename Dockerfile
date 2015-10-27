FROM    buildpack-deps:curl
MAINTAINER Samuel Boucher
LABEL description="Basis for Java, Maven app" version="0.1"
ENV MAVEN_TAR="apache-maven-3.3.3-bin.tar.gz" \
    JDK8_TAR="jdk-8u65-linux-x64.tar.gz" \
    JDK7_TAR="jdk-7u79-linux-x64.tar.gz"\
    JCE_ZIP="jce_policy-8.zip"\
    JAVA_HOME=/usr/local/jvm/latest8


ENV MAVEN_URL="http://apache.mirror.iweb.ca/maven/maven-3/3.3.3/binaries/${MAVEN_TAR}" \
    JDK8_URL="http://download.oracle.com/otn-pub/java/jdk/8u65-b14/${JDK8_TAR}" \
    JDK7_URL="http://download.oracle.com/otn-pub/java/jdk/7u79-b15/${JDK7_TAR}"\
    JCE_POLICY="https://edelivery.oracle.com/otn-pub/java/jce/8/${JCE_ZIP}"\
    PATH=${JAVA_HOME}/bin:/usr/local/maven/maven-3.3.3/bin:${PATH}

WORKDIR /opt
RUN apt-get update -y && apt-get install tmux rsync vim unzip -y
RUN  wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JDK8_URL} \
 &&  wget  --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JCE_POLICY} \
 && unzip ${JCE_ZIP} && rm ${JCE_ZIP}\
 && tar -xf ${JDK8_TAR} && rm ${JDK8_TAR}
RUN cd /usr/local \
 && mkdir jvm \
 && cd -\
 && ln -s /opt/jdk1.8.0_65 /usr/local/jvm/latest8
RUN cp UnlimitedJCEPolicyJDK8/local_policy.jar $JAVA_HOME/lib/security