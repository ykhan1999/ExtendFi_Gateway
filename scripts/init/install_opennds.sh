#!/usr/bin/bash
sudo apt install -y libmicrohttpd-dev
git clone https://github.com/ykhan1999/openNDS-ExtendFi
cd openNDS-ExtendFi
make
sudo make install
sudo cp resources/opennds.conf.ExtendFi /etc/config/opennds
sudo cp resources/theme_click-to-continue-basic.sh /usr/lib/opennds/theme_click-to-continue-basic.sh
