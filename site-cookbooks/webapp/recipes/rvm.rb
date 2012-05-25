# install app specific ruby and gemset

include_recipe 'rvm::system_install'

ruby, gemset = node.webapp.rvm.ruby_string.split('@')
gemset ||= node.webapp.user.name

raise "gemset is not specified" if gemset.nil?

rvm_ruby ruby do
  action :install
end

rvm_gemset gemset do
  ruby_string ruby
  action :create
end
