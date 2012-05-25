name 'web_server'
description 'Build a nginx web server'
run_list 'recipe[nginx::source]'

default_attributes :nginx => {:version => '1.2.0'}
