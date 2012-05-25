require 'pathname'
include_recipe 'nginx::source'

template "#{node[:nginx][:dir]}/sites-available/#{node.webapp.user.name}" do
  source "unicorn_site.erb"
  owner node.webapp.user.name
end

nginx_site node.webapp.user.name

apps_root = Pathname.new(node.webapp.site.apps_root)

directory apps_root.to_s do # default is /u/apps
  owner node.webapp.deployer.name
  group 'webapp'
  mode "0775"
  action :create
  recursive true
end


directory (apps_root + node.webapp.name).to_s do # default is /u/apps
  owner node.webapp.user.name
  group node.webapp.user.name
  mode "0755"
  action :create
end


