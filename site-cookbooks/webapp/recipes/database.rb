include_recipe 'database'

conn_info = {:host => "127.0.0.1",
              :port => 5432,
              :username => 'postgres',
              :password => node[:postgresql][:password][:postgres]}

dbname = node.webapp.database.dbname || "#{node.webapp.name}_#{node.webapp.env}"

postgresql_database dbname do
  connection conn_info
  action :create
end

db_username = node.webapp.database.username || node.webapp.name
postgresql_database_user db_username do
  connection conn_info
  password node.webapp.database.password
  action :create
end

