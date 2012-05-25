name 'rails_server'
description 'Build a rails application environment'
run_list(
         'recipe[rvm::system]',
         'recipe[webapp::database]',
         'recipe[webapp::user]',
         'recipe[webapp::rvm]',
         'recipe[webapp::site]'
        )

default_attributes( 
  :rvm => {
    :default_ruby => "system",
    :rubies => ["ruby-1.9.3-p194"],
    :global_gems => [
      {'name' => 'bundler'},
      {'name' => 'rake'},
    ]
  }
)
