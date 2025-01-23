# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'
Vagrant.configure("2") do |config|
  config.vm.define "manager01", primary: true do |manager|
    manager.vm.hostname = "manager"
    manager.vm.box = "ubuntu/focal64"
    manager.vm.network "private_network", ip: "192.168.56.10"
    manager.vm.network "forwarded_port", guest: 8087, host: 8087
    manager.vm.network "forwarded_port", guest: 8081, host: 8081
    manager.vm.network "forwarded_port", guest: 9090, host: 9090
    manager.vm.network "forwarded_port", guest: 9000, host: 9000
    manager.vm.network "forwarded_port", guest: 3000, host: 3000
    manager.vm.provision "shell", path: "./setup_manager.sh"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = "8192"
      vb.cpus = 4
    end
  end

  config.vm.define "worker01" do |worker01|
    worker01.vm.hostname = "worker01"
    worker01.vm.box = "ubuntu/focal64"
    worker01.vm.network "private_network", ip: "192.168.56.11"
    worker01.vm.provision "shell", path: "./setup_worker.sh"
  end
  
  config.vm.define "worker02" do |worker02|
    worker02.vm.hostname = "worker02"
    worker02.vm.box = "ubuntu/focal64"
    worker02.vm.network "private_network", ip: "192.168.56.12"
    worker02.vm.provision "shell", path: "./setup_worker.sh"
  end

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 2
  end
end
