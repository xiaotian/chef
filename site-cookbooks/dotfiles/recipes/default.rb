sudo_user = ENV['SUDO_USER'] or raise "unable to determine original user before sudo"
execute 'git clone dotfiles repo' do
  user sudo_user
  group sudo_user
  command 'cd ~/ && git clone git://github.com/xiaotian/dotfiles.git .dotfiles'
  creates File.expand_path '~/.dotfiles/Rakefile'
  action :run
end

execute 'update git submodules' do
  user sudo_user
  group sudo_user
  command 'cd ~/.dotfiles && git submodule update --init'
  creates File.expand_path '~/.dotfiles/vim/bundle/nerdtree/Rakefile'
  action :run
end

gem_package 'rake' do
  action :install
end

execute 'generate dotfiles' do
  user sudo_user
  group sudo_user
  command 'cd ~/.dotfiles && rake install[true]'
  environment({'full_name' => "#{node[:dotfiles][:full_name] || 'Full Name'}",
               'email' => "#{node[:dotfiles][:email] || 'Email Address'}",
               'github_username' => "#{node[:dotfiles][:github_username] || 'Github username'}"})
  creates File.expand_path '~/.gitconfig'
  action :run
end
