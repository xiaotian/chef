
sudo_user = ENV['SUDO_USER']
ruby_str = 'ruby-1.9.3-p194@rails'

node['rvm']['user_installs'] = [
    { 'user' => sudo_user }
]

node['rvm']['user_default_ruby'] = ruby_str

node['rvm']['user_global_gems'] = [
    { 'name' => 'bundler' },
    { 'name' => 'rake' },
    { 'name' => 'pry' }
]

include_recipe 'rvm::user' # seems this has to go after the node[] assignment above

rvm_gem "rails" do
  user sudo_user
  ruby_string ruby_str
  action :install
end
