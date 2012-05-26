# create deployment user
deployer_name = node.webapp.deployer.name
user deployer_name do
  comment 'web application deployer'
  home "/home/#{deployer_name}"
  shell '/bin/bash'
  password node.webapp.deployer.password_hash
  supports :manage_home => true
  action :create
end

# create .ssh directory for deployer
directory File.join('/home', deployer_name, '.ssh') do # default is /u/apps
  owner deployer_name
  group deployer_name
  mode "0700"
  action :create
  recursive true
end

# create authorized_keys for deployer
cookbook_file File.join('/home', deployer_name, '.ssh', 'authorized_keys') do
  source 'id_rsa_deploy.pub'
  mode "0700"
  owner deployer_name
  group deployer_name
  action :create_if_missing
end

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
  members [username, deployer_name]
  append true
  action :create
end

#add the deployer to admin group (NOPASSWD sudoer)
group 'admin' do
  members [deployer_name]
  append true
  action :manage # raises if rvm group doesn't already exist
end

#add the user to rvm group
group 'rvm' do
  members [username, deployer_name]
  append true
  action :manage # raises if rvm group doesn't already exist
end
