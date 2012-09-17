# modified from:
# http://stackoverflow.com/questions/9938314/chef-how-to-run-a-template-that-creates-a-init-d-script-before-the-service-is-c

app_name = node.webapp.name

service app_name do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

template app_name do
  path "/etc/init.d/#{app_name}"
  source "unicorn_init.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[#{app_name}]"
  notifies :start, "service[#{app_name}]"
end
