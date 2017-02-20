template '/etc/apache2/apache2.conf' do
  source 'apache2.conf.erb'
end

service 'apache2' do
  action :restart
end
