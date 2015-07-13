# include the vim configs
include_recipe 'ubuntu-essentials::vim'
package 'vim-gnome'

# install rcfile to all desired users
rcfile_helper('gvim', 'gvimrc')
