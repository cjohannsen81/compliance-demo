case node[:platform]
when "ubuntu"
  execute 'compliance-download' do
    command 'curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -P compliance'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "compliance-download"), :immediately
  end

#  execute 'compliance-install' do
#    command 'sudo apt-get install chef-compliance=0.15.13-1'
#  end

#  package "update-notifier-common" do
#    notifies :run, resources(:execute => "compliance-install"), :immediately
#  end

  execute 'compliance-config' do
   command 'chef-compliance-ctl reconfigure --accept-license'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "compliance-config"), :immediately
  end

  node['ubuntu']['packages'].each do |pack|
    package pack

    package "update-notifier-common" do
      notifies :install, resources(:package => "#{pack}"), :immediately
    end
  end

  execute 'chefdk-install' do
    command 'curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "chefdk-install"), :immediately
  end



end
