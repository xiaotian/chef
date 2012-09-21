

default[:webapp][:database][:dbname] = nil  # default to #{webapp.name}_#{webapp.env}
default[:webapp][:database][:username] = nil # default to webapp.name
default[:webapp][:database][:password] = "password"

