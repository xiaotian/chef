include_recipe 'database'

conn_info = {:host => "127.0.0.1",
              :port => 5432,
              :username => 'postgres',
              :password => node[:postgresql][:password][:postgres]}

postgresql_database node[:appdb][:database] do
  connection conn_info
  action :create
end

postgresql_database_user node[:appdb][:username] do
  connection conn_info
  password node[:appdb][:password]
  action :create
end
