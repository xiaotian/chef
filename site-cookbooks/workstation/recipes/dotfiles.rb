
username = node.workstation.user.username 
execute 'git clone dotfiles repo' do
  user username
  group username
  command "cd ~#{username} && git clone git://github.com/xiaotian/dotfiles.git .dotfiles"
  creates File.expand_path "~#{username}/.dotfiles/Rakefile"
  action :run
end

execute 'update git submodules' do
  user username
  group username
  command "cd ~#{username}/.dotfiles && git submodule update --init"
  creates File.expand_path "~#{username}/.dotfiles/vim/bundle/nerdtree/Rakefile"
  action :run
end

gem_package 'rake' do
  action :install
end

execute 'generate dotfiles' do
  user username
  group username
  command "cd ~#{username}/.dotfiles && rake install[true]"
  environment({'HOME' => "/home/#{username}",
               'full_name' => "#{node.workstation.user.full_name || 'Full Name'}",
               'email' => "#{node.workstation.user.email || 'Email Address'}",
               'github_username' => "#{node.workstation.user.github_username || 'Github username'}"})
  creates File.expand_path "~#{username}/.gitconfig"
  action :run
end

