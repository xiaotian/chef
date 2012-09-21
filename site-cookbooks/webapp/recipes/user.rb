
#create user for webapp
username = node.webapp.user.name || node.webapp.name

user username do
  comment 'web application user'
  home "/home/#{username}"
  shell '/bin/bash'
  password node.webapp.user.password_hash
  supports :manage_home => true
  action :create
end

#add the user to deploy group
group 'webapp' do
  members [username]
  append true
  action :create
end

#add the user to rvm group
group 'rvm' do
  members [username]
  append true
  action :manage # raises if rvm group doesn't already exist
end

# create .ssh directory for user
directory File.join('/home', username, '.ssh') do # default is /u/apps
  owner username
  group username
  mode "0700"
  action :create
  recursive true
end

# create authorized_keys for user
cookbook_file File.join('/home', username, '.ssh', 'authorized_keys') do
  source 'id_rsa_deploy.pub'
  mode "0700"
  owner username
  group username
  action :create_if_missing
end

# put a user level rvmrc file with trust setting that prevent rvm from prompt permission
cookbook_file File.join('/home', username, '.rvmrc') do
  source 'rvmrc'
  owner username
  group username
  action :create_if_missing
end
# create sudoer entry for webapp group
# security hole - do not use.

# cookbook_file '/etc/sudoers.d/webapp' do
#   source 'webapp.sudo'
#   mode "0400"
#   owner 'root'
#   group 'root'
#   action :create_if_missing
# end
