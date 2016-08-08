Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo This becomes a Chef Compliance Demo environment."

  config.vm.define "chef-compliance" do |comp|
    comp.vm.box = "ubuntu/trusty64"
    comp.vm.network "public_network", bridge: "en1: WLAN (AirPort)"
    comp.vm.network "private_network", ip: "192.168.1.10",
        virtualbox__intnet: true
    comp.vm.provision "chef_solo" do |chef|
      chef.version = "12.10.24"
      chef.add_recipe "compliance"
    end
    comp.vm.provision "chef_solo" do |chef|
      chef.version = "12.10.24"
      chef.add_recipe "config"
    end
    comp.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", 2048]
      vb.customize ["modifyvm", :id, "--cpus", 2]
      vb.customize ["modifyvm", :id, "--vram", "64"]
      vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end
  end

  config.vm.define "comp-node01" do |linux|
    linux.vm.box = "ubuntu/trusty64"
    linux.vm.network "private_network", ip: "192.168.1.11",
        virtualbox__intnet: true
  end

  config.vm.define "comp-node02" do |windows|
    windows.vm.box = "ferventcoder/win7pro-x64-nocm-lite"
    windows.vm.hostname = "win"
    windows.vm.communicator = "winrm"
    windows.vm.network "private_network", ip: "192.168.1.12",
      virtualbox__intnet: true
    windows.vm.network "forwarded_port", guest: 389, host: 3389
    windows.vm.provision "shell",
      inline: 'netsh "advfirewall" "set" "allprofiles" "state" "off"'

    windows.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 512]
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--vram", "32"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    end
  end
end
