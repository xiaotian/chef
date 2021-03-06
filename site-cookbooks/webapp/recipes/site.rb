require 'pathname'
include_recipe 'nginx::source'

username = node.webapp.user.name || node.webapp.name
template "#{node[:nginx][:dir]}/sites-available/#{node.webapp.name}" do
  source "unicorn_site.erb"
  owner username
end


apps_root = Pathname.new(node.webapp.site.apps_root)

directory apps_root.to_s do # default is /u/apps
  owner 'root'
  group 'webapp'
  mode "0775"
  action :create
  recursive true
end

if node.webapp.site.create_app_dir #default false: allow capistrano to create the directory so it can set permission
  directory (apps_root + node.webapp.name).to_s do # default is /u/apps
    owner username
    group username
    mode "0755"
    action :create
  end
end

if node.webapp.site.disable_distro_default
  execute 'disable distro default site if any' do # nginx package installs a default site which will mask ours
    command "rm -f #{node.nginx.dir}/sites-enabled/*default"
    action :run
  end
end

nginx_site(node.webapp.name) if node.webapp.site.enable

