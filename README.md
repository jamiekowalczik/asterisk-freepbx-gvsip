# asterisk-freepbx
Want a fully capable PBX for pretty much free??

Setup Asterisk & FreePBX in a Virtual Machine running on some spare old hardware.  I provision 40G of storage and 512MB of memory.

Prerequisites: VirtualBox Vagrant git

1.) # mkdir asterisk-freepbx; cd asterisk-freepbx

2.) # git clone https://github.com/jamiekowalczik/asterisk-freepbx.git

3.) update Vagrantfile with the appropriate bridge name (replace wlo1) and IP address.

4.) # vagrant up

5.) When the machine is fully setup browse to http://<IP Address> and setup a username, password, email address to send alerts to.

6.) From Admin-->Modules, Update from the internet and choose Extended and Unsupported then install Google Motif

7.) From Connectivity-->Google Voice(Motif) fill in your Google Voice credentials and number and choose to create trunks/etc.

8.) Start setting up phones...

9.) More to come.
