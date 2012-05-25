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

#create user for webapp
username = node.webapp.user.name

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
