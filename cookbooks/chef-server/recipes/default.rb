#
# Cookbook Name:: chef-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
case node[:platform]
when "ubuntu"
  execute 'chef-server-download' do
    command 'wget https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/chef-server-core_12.0.8-1_amd64.deb'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "chef-server-download"), :immediately
  end

  execute 'chef-server-install' do
    command 'sudo dpkg -i chef-server-core_*.deb'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "chef-server-install"), :immediately
  end

  execute 'chef-server-config' do
    command 'sudo chef-server-ctl reconfigure'
  end

  package "update-notifier-common" do
    notifies :run, resources(:execute => "chef-server-config"), :immediately
  end
end
