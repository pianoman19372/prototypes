name 'edl-desktop'
description 'custom stuff for my desktop'

override_attributes({
})

run_list(
   'recipe[ubuntu-essentials::bash]',
   'recipe[ubuntu-essentials::htop]',
   'recipe[ubuntu-essentials::grub]',
   'recipe[ubuntu-essentials::vagrant]',
   'recipe[ubuntu-essentials::vim]',
   'recipe[ubuntu-essentials::gvim]',
   'recipe[ubuntu-essentials::xmodmap]',
   'recipe[ubuntu-essentials::xfce4]'
)
