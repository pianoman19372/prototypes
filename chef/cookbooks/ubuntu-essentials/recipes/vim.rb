# vim configs
package 'vim'

# .vimrc file (using the rcfile library helper)
rcfile_helper('vim', 'vimrc')

# install vim configs for root
if node['ubuntu-essentials']['configure_root']
    install_vim_config('/', 'root')
end

# install vim configs for local users
node['ubuntu-essentials']['users'].each do |username|
    install_vim_config(node['ubuntu-essentials']['homedir_path'], username)
end

# install fonts required for powerline
%w(Inconsolata-dz-Powerline.otf Menlo-Powerline.otf mensch-Powerline.otf).each do |font|
    cookbook_file "/usr/share/fonts/#{font}" do
        source "vim/fonts/#{font}"
        owner 'root'
        group 'root'
        mode 0444
    end
end
