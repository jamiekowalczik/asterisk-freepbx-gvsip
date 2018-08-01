#!/bin/bash
## Install as root
## bash <(curl -s https://raw.githubusercontent.com/jamiekowalczik/asterisk-freepbx/master/provision/install.bash)
yum -y install git python-virtualenv
virtualenv ansible
. ./ansible/bin/activate
pip install pip -U
pip install setuptools -U
pip install ansible
git clone https://github.com/jamiekowalczik/asterisk-freepbx.git
cd asterisk-freepbx/provision
echo ""
read -p "Update asterisk-freepbx/provision/freepbx-gvsip-el7.yml to include your GVSIP details then press enter to continue"
ansible-playbook freepbx-gvsip-el7.yml -i inventory
