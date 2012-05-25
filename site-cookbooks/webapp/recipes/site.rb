require 'pathname'
include_recipe 'nginx::source'

username = node.webapp.user.name || node.webapp.name
template "#{node[:nginx][:dir]}/sites-available/#{node.webapp.name}" do
  source "unicorn_site.erb"
  owner username
end

nginx_site node.webapp.name

apps_root = Pathname.new(node.webapp.site.apps_root)

directory apps_root.to_s do # default is /u/apps
  owner node.webapp.deployer.name
  group 'webapp'
  mode "0775"
  action :create
  recursive true
end


directory (apps_root + node.webapp.name).to_s do # default is /u/apps
  owner username
  group username
  mode "0755"
  action :create
end


