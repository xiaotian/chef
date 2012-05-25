include_recipe 'database'

conn_info = {:host => "127.0.0.1",
              :port => 5432,
              :username => 'postgres',
              :password => node[:postgresql][:password][:postgres]}

postgresql_database node[:webapp][:database][:dbname] do
  connection conn_info
  action :create
end

postgresql_database_user node[:webapp][:database][:username] do
  connection conn_info
  password node[:webapp][:database][:password]
  action :create
end

