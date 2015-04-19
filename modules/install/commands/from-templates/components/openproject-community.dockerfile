## OpenProject ----------------------------------------------------------------
#
# https://www.openproject.org/open-source/download/packaged-installation-community/
#

RUN wget -qO - https://deb.packager.io/key | apt-key add - && \
    echo "deb https://deb.packager.io/gh/finnlabs/pkgr-openproject-community trusty stable" > /etc/apt/sources.list.d/pkgr-openproject-community.list && \
    apt-get install -y apt-transport-https && apt-get update && apt-get install -y openproject-ce

