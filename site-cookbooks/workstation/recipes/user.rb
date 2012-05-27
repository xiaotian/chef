username = node.workstation.user.username
user username do
  comment 'workstation user'
  home "/home/#{username}"
  shell '/bin/bash'
  password node.workstation.user.password_hash
  supports :manage_home => true
  action :create
end


if node.workstation.user.admin
  #add the user to deploy group
  group 'admin' do
    members [username]
    append true
    action :create
  end
end
