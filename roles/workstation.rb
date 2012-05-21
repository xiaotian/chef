name 'workstation'
description 'Deploy dotfiles for a workstation'
run_list 'recipe[mytools]', 'recipe[dotfiles]'
