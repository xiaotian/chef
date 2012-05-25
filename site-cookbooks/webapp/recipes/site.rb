
template "#{node[:nginx][:dir]}/sites-available/#{node.webapp.user.name}" do
  source "unicorn_site.erb"
  owner node.webapp.user.name
end

nginx_site node.webapp.user.name
