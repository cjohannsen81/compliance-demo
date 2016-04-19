cookbook_file '/usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf' do
  source '50-ubuntu.conf'
  action :create
end

cookbook_file '/etc/environment' do
  source 'environment'
  action :create
end

remote_directory '/profiles' do
  source 'profiles'
  action :create
end

execute "reboot" do
  command 'sudo shutdown -r now'
end

package "update-notifier-common" do
  notifies :run, resources(:execute => "reboot"), :immediately
end

execute 'inspec-install' do
  command 'chef gem install inspec'
end

package "update-notifier-common" do
  notifies :run, resources(:execute => "inspec-install"), :immediately
end
