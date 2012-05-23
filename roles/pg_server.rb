name 'pg_server'
description 'Setup a PostgreSQL server instance'
run_list(
  "recipe[apt]", # for apt_postgresql_ppa below
  "recipe[postgresql::apt_postgresql_ppa]",
  "recipe[postgresql::server]",
  "recipe[database]"
)

override_attributes(
  :postgresql => {
    :password => {
      :postgres => 'passw@rd'
    },
    :version => "9.1",
    :dir => "/etc/postgresql/9.1/main"  # IF you don't include this, chef tries to find 
  }                                     # postgresql config files in /etc/postgresql/8.4/main
)

