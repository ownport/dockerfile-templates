## jenkins - An extensible open source continuous integration server
# https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu

RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
	echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update && apt-get install -y jenkins

