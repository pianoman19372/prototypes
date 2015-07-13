# method to install rc file for a specific user
def rcfile(base_path, username, recipe, name)
    # install specified .rcfile
    cookbook_file "#{base_path}#{username}/.#{name}" do
        source "#{recipe}/#{name}"
        owner username
        group username
        mode '0640'
    end
end

# method to install rc files to all configured users
def rcfile_helper(recipe, name)
    # install vim configs for root
    if node['ubuntu-essentials']['configure_root']
        rcfile('/', 'root', recipe, name)
    end

    # install vim configs for local users
    node['ubuntu-essentials']['users'].each do |username|
        rcfile('/home/', username, recipe, name)
    end
end
