name 'workstation'
description 'Create a reasonable workstation user environment'
run_list( 
  'recipe[mytools]', 
  'recipe[workstation::user]', 
  'recipe[workstation::dotfiles]'
)
