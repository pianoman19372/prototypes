# simple method to automate vim config creation
def install_vim_config(base_path, username)

    # create initial dirs
    dirs = [
        "#{base_path}#{username}/.vim",
        "#{base_path}#{username}/.vim/autoload",
    ]

    dirs.each do |directory_path|
        directory directory_path do
            owner username
            group username
            mode '0770'
        end
    end

    # install pathogen
    cookbook_file "#{base_path}#{username}/.vim/autoload/pathogen.vim" do
        source "vim/autoload/pathogen.vim"
        owner username
        group username
        mode '0640'
    end

    # install bundles: 1 time / first run only (bootstrap recipe)
    bash "vim-#{username}-post-deploy-hook" do
        code <<-EOH
            cd #{base_path}#{username}/.vim/
            tar -xzf bundle.tar.gz
            find #{base_path}#{username}/.vim -type d -exec chmod 0770 {} \\;
            find #{base_path}#{username}/.vim -type f -exec chmod 0640 {} \\;
            find #{base_path}#{username}/.vim -exec chown #{username}:#{username} {} \\;
            rm -f bundle.tar.gz
        EOH
        user 'root'
        group 'root'
        action :nothing
    end

    # bundle install tar.gz file
    cookbook_file "#{base_path}#{username}/.vim/bundle.tar.gz" do
        source "vim/bundle.tar.gz"
        owner 'root'
        group 'root'
        mode '0640'
        not_if { ::File.directory?("#{base_path}#{username}/.vim/bundle") }
        notifies :run, "bash[vim-#{username}-post-deploy-hook]", :immediately
    end
end
