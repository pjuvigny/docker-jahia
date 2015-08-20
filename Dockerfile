FROM    centos:centos7

MAINTAINER pierre.juvigny@capgmeini.com

# Install stuff
RUN 	yum install -y git
RUN 	yum install -y mod_dav_svn subversion
RUN     yum install -y tar
RUN     yum install -y wget
RUN     yum install -y java-1.8.0-openjdk-devel.x86_64
RUN		yum clean all

# Install Maven
RUN 	wget http://mirrors.gigenet.com/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
RUN 	tar -zxvf apache-maven-3.3.3-bin.tar.gz -C /usr/local
RUN 	ln -s /usr/local/apache-maven-3.3.3 /usr/local/maven

ENV 	M2_HOME=/usr/local/maven
ENV 	M2=/usr/local/maven/bin
ENV 	PATH=/usr/local/maven/bin:$PATH

# Install Jahia
ADD 	install /tmp/install
WORKDIR /tmp/install
RUN 	wget http://downloads.jahia.com/public/digitalfactory-7.1.0/bin/DigitalFactory-CommunityDistribution-7.1.0.0-r52740.jar
RUN 	java -jar DigitalFactory-CommunityDistribution-7.1.0.0-r52740.jar InstallScript
RUN 	rm -rf /tmp/install

WORKDIR /opt/jahia-7.1.0.0

EXPOSE 8080

CMD 	["/opt/jahia-7.1.0.0/startDigitalFactory.sh"]

