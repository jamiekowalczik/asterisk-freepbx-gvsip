# asterisk-freepbx-gvsip
Want a fully capable PBX for pretty much free??

Setup Asterisk & FreePBX in a VirtualBox Virtual Machine.

Prerequisites: VirtualBox Vagrant git google voice

1.) # git clone https://github.com/jamiekowalczik/asterisk-freepbx-gvsip.git

2.) update Vagrantfile with the appropriate bridge name (replace wlo1) and IP address.

3.) # cd asterisk-freepbx-gvsip; vagrant up

4.) When the machine is fully setup browse to http://<IP Address> and setup a username, password, email address to send alerts to then setup the time zone.

5.) TODO: explain how to obtain the google voice values needed for setting up the trunks.  Setup the trunks, inbound, and outbound routes.

7.) Start setting up phones...

8.) More to come.

------------------------------------
Additionally if you have a base Centos 7 install that you'd like to use as your PBX rather than using Vagrant to provision a virtual machine, use the following:

```
bash <(curl -s https://raw.githubusercontent.com/jamiekowalczik/asterisk-freepbx-gvsip/master/provision/install.bash)
```
