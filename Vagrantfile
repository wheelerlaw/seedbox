# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.network "forwarded_port", guest: 49155, host: 49155
  config.vm.network "forwarded_port", guest: 3000, host: 8080
  # config.vm.provision "file", source: "rtorrent.rc", destination: "$HOME/.rtorrent.rc"
  config.vm.provision "shell", path: "setup.sh"
end
