FROM    buildpack-deps:curl
MAINTAINER Samuel Boucher
LABEL description="Basis for Java App" version="8u65"
ENV JDK8_TAR="jdk-8u65-linux-x64.tar.gz" \
    JCE_ZIP="jce_policy-8.zip"\
    JAVA_HOME=/usr/local/jvm/latest8


ENV JDK8_URL="http://download.oracle.com/otn-pub/java/jdk/8u65-b14/${JDK8_TAR}" \
    JCE_POLICY="https://edelivery.oracle.com/otn-pub/java/jce/8/${JCE_ZIP}"\
    PATH=${JAVA_HOME}/bin:${PATH}

WORKDIR /opt
RUN apt-get update -qq -y && apt-get -qq install tmux rsync vim unzip -y \
 &&  wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JDK8_URL} \
 &&  wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  ${JCE_POLICY} \
 && unzip ${JCE_ZIP} && rm ${JCE_ZIP}\
 && tar -xf ${JDK8_TAR} && rm ${JDK8_TAR}\
 &&  cd /usr/local \
 && mkdir jvm \
 && cd -\
 && ln -s /opt/jdk1.8.0_65 /usr/local/jvm/latest8\
 && cp UnlimitedJCEPolicyJDK8/* $JAVA_HOME/jre/lib/security/