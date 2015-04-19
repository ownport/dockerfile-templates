## OpenProject ----------------------------------------------------------------
#
# https://www.openproject.org/open-source/download/packaged-installation-community/
#

RUN wget -qO - https://deb.packager.io/key | sudo apt-key add - && \
    echo "deb https://deb.packager.io/gh/finnlabs/pkgr-openproject-community trusty stable" > /etc/apt/sources.list.d/pkgr-openproject-community.list && \
    apt-get update && apt-get install openproject-ce

