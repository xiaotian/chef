require 'pathname'
include_recipe 'nginx::source'

username = node.webapp.user.name || node.webapp.name
template "#{node[:nginx][:dir]}/sites-available/#{node.webapp.name}" do
  source "unicorn_site.erb"
  owner username
end


apps_root = Pathname.new(node.webapp.site.apps_root)

directory apps_root.to_s do # default is /u/apps
  owner node.webapp.deployer.name
  group 'webapp'
  mode "0775"
  action :create
  recursive true
end

if node.webapp.create_app_dir #default false: allow capistrano to create the directory so it can set permission
  directory (apps_root + node.webapp.name).to_s do # default is /u/apps
    owner username
    group username
    mode "0755"
    action :create
  end
end

nginx_site(node.webapp.name) if node.webapp.site.enable

