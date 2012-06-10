
username = node.workstation.user.username

ruby_str = node.workstation.rvm.ruby_string

node['rvm']['user_installs'] = [
    { 'user' => username }
]

node['rvm']['user_default_ruby'] = ruby_str

node['rvm']['user_global_gems'] = [
    { 'name' => 'bundler' },
    { 'name' => 'rake' },
    { 'name' => 'cheat' },
    { 'name' => 'pry-doc' },
    { 'name' => 'pry' }
]

include_recipe 'rvm::user' # seems this has to go after the node[] assignment above

rvm_gem "rails" do
  user username
  ruby_string ruby_str
  action :install
end

