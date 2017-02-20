Vagrant.configure("2") do |config|

  config.vm.provision 'shell' do |s|
    s.inline = <<-SHELL
     echo "127.0.0.1 localhost" | tee /etc/hosts
     echo "192.168.100.10 chefserver" | tee -a /etc/hosts
     echo "192.168.100.20 complianceserver" | tee -a /etc/hosts
     echo "192.168.100.30 webserver" | tee -a /etc/hosts
     echo "192.168.100.40 winserver" | tee -a /etc/hosts
    SHELL
  end

  config.vm.define 'Chef Server' do |chefserver|
    chefserver.vm.box = 'ubuntu/trusty64'
    chefserver.vm.hostname = 'chefserver'
    chefserver.vm.network 'private_network', ip: '192.168.100.10'
    chefserver.vm.provision 'file', source: 'chef-server-core_12.11.1-1_amd64.deb', destination: '/tmp/chef-server-core_12.11.1-1_amd64.deb'
    chefserver.vm.provision 'file', source: 'chef-manage_2.4.4-1_amd64.deb', destination: '/tmp/chef-manage_2.4.4-1_amd64.deb'
    chefserver.vm.provision 'shell', inline: 'dpkg -i /tmp/chef-server-core_12.11.1-1_amd64.deb'
    chefserver.vm.provision 'shell', inline: 'sudo chef-server-ctl reconfigure'
    chefserver.vm.provision 'shell', inline: 'sudo chef-server-ctl install chef-manage --path /tmp/chef-manage_2.4.4-1_amd64.deb'
    chefserver.vm.provision 'shell', inline: 'sudo chef-server-ctl reconfigure'
    chefserver.vm.provision 'shell', inline: 'sudo chef-manage-ctl reconfigure --accept-license'
    chefserver.vm.provision 'shell', inline: 'sudo chef-server-ctl user-create cjohannsen Christian Johannsen cjohannsen@chef.com "chefdemo" --filename cjohannsen.pem'
    chefserver.vm.provision 'shell', inline: 'sudo chef-server-ctl org-create acmeorg "acme organization" --filename ~/acme-validator.pem -a cjohannsen'
    chefserver.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end
  end

  config.vm.define 'Compliance Server' do |complianceserver|
    complianceserver.vm.box = 'ubuntu/trusty64'
    complianceserver.vm.hostname = 'complianceserver'
    complianceserver.vm.network 'private_network', ip: '192.168.100.20'
    complianceserver.vm.provision 'file', source: 'chef-compliance_1.6.8-1_amd64.deb', destination: '/tmp/chef-compliance_1.6.8-1_amd64.deb'
    complianceserver.vm.provision 'shell', inline: 'dpkg -i /tmp/chef-compliance_1.6.8-1_amd64.deb'
    complianceserver.vm.provision 'shell', inline: 'sudo chef-compliance-ctl reconfigure --accept-license'
    complianceserver.vm.provider :virtualbox do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
  end

  config.vm.define 'Webserver' do |webserver|
    webserver.vm.box = 'ubuntu/trusty64'
    webserver.vm.hostname = 'webserver'
    webserver.vm.network 'private_network', ip: '192.168.100.30'
    webserver.vm.provider :virtualbox do |vb|
      vb.memory = 512
      vb.cpus = 1
    end
  end

  config.vm.define 'Winserver' do |winserver|
    winserver.vm.box = 'windows-2012r2'
    winserver.vm.hostname = 'winserver'
    winserver.vm.network 'private_network', ip: '192.168.100.40'
    winserver.vm.provider :virtualbox do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end
  end

end
