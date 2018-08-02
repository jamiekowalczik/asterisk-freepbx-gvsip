# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "asterisk-freepbx-gvsip"

  config.vm.network "public_network", ip: "192.168.2.128"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.name = "asterisk-1"
  end
  
  config.vm.synced_folder "./provision", "/home/vagrant/provision", type: "rsync"

  config.vm.provision :ansible_local do |ansible|
    ansible.provisioning_path = "/home/vagrant/provision"
    ansible.inventory_path = "inventory"
    ansible.playbook = "freepbx-gvsip-el7.yml"
    ansible.limit = "all"
  end
end
