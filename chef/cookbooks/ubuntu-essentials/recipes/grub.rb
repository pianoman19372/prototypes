# recipe to configure grub with my custom MTRR and boot options
package 'grub2-common'
package 'memtest86+'

execute 'update-grub2' do
    command '/usr/sbin/update-grub2'
    action :nothing
    user 'root'
    group 'root'
end

cookbook_file "/etc/default/grub" do
    source "grub/default"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'execute[update-grub2]', :immediately
end
