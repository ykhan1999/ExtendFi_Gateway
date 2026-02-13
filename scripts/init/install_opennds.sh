#!/usr/bin/env bash
sudo apt install -y libmicrohttpd-dev
sudo apt install -y iptables
git clone https://github.com/ykhan1999/openNDS-ExtendFi
cd openNDS-ExtendFi
make
sudo make install
sudo cp resources/opennds.conf.ExtendFi /etc/config/opennds
sudo cp resources/theme_click-to-continue-basic.sh /usr/lib/opennds/theme_click-to-continue-basic.sh
#add captive portal overrides
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo mkdir -p /etc/NetworkManager/dnsmasq-shared.d
sudo cp $SCRIPT_DIR/helpers/captive-portal.conf /usr/local/etc/