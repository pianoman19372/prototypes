# user defined parameters of Makefile
#
# Note: these must match whats in the Vagrantfile

# chef sever
SRV_IP=192.168.1.2
SRV_HOST=chefserver

# organization
ORG_NAME=studio9

# user details
CHEF_USER=edl
CHEF_NAME=Edward Long
CHEF_EMAIL=myemail@example.com
CHEF_PASS=abcdef12345

# local paths of things
SRV_PATH=/storage/git/chef
USR_PATH=/root

# these targets run locally on the node hosting the vagrant chefserver VM
install: ./.vagrant/machines/chefserver chef-dk dns-change knife-client

dns-change:
	# this is just a hack to get us around not having bind9 up yet
	grep -v "$(SRV_HOST)" /etc/hosts > /etc/hosts.new
	echo "$(SRV_IP) $(SRV_HOST)" >> /etc/hosts.new
	mv /etc/hosts /etc/hosts.bak
	mv /etc/hosts.new /etc/hosts

chef-dk:
	dpkg -i debs/chefdk_0.6.2-1_amd64.deb

knife-client:
	# configure knife.rb
	mkdir -p $(USR_PATH)/.chef/trusted_certs
	cp $(SRV_PATH)/config/knife.rb       $(USR_PATH)/.chef/knife.rb
	sed -i 's,SRV_PATH,$(SRV_PATH),'     $(USR_PATH)/.chef/knife.rb
	sed -i 's,SRV_HOST,$(SRV_HOST),'     $(USR_PATH)/.chef/knife.rb
	sed -i 's,ORG_NAME,$(ORG_NAME),'     $(USR_PATH)/.chef/knife.rb
	sed -i 's,CHEF_USER,$(CHEF_USER),'   $(USR_PATH)/.chef/knife.rb
	sed -i 's,CHEF_NAME,$(CHEF_NAME),'   $(USR_PATH)/.chef/knife.rb
	sed -i 's,CHEF_EMAIL,$(CHEF_EMAIL),' $(USR_PATH)/.chef/knife.rb
	sed -i 's,USR_PATH,$(USR_PATH),'     $(USR_PATH)/.chef/knife.rb
	# add trusted ssl certs
	cp $(SRV_PATH)/config/*.crt $(USR_PATH)/.chef/trusted_certs/
	/usr/bin/knife ssl check
	/usr/bin/knife client list

./.vagrant/machines/chefserver:
	vagrant up chefserver

bootstrap:
	# example only, not automating this step ;)
	knife bootstrap 192.168.1.1 -x USERNAME -P PASSWORD --sudo
	knife node run_list add studio9 role[edl-desktop]
	knife node environment_set studio9 production

upload:
	#knife environment from file environments/*.rb
	#knife role from file roles/*.rb
	knife cookbook upload ubuntu-essentials

# this target is used to reset the chefserver
clean:
	vagrant destroy -f chefserver
	-rm -rf $(SRV_PATH)/.vagrant/machines/chefserver
	-rm -rf $(USR_PATH)/.chef
	-rm -f $(SRV_PATH)/config/*.pem
	-rm -f $(SRV_PATH)/config/*.crt

# these targets run on the vagrant vm and are bootstrapped by the shell provisioner
install-server: install-chef

# install extras manually, i dont always need em
install-extras: install-manager install-pushjobs install-reporting install-replication

install-chef:
	# chef
	dpkg -i debs/chef-server-core_12.1.0-1_amd64.deb
	chef-server-ctl reconfigure
	chef-server-ctl user-create $(CHEF_USER) "$(CHEF_NAME)" $(CHEF_EMAIL) $(CHEF_PASS) --filename $(SRV_PATH)/config/$(CHEF_USER).pem
	chef-server-ctl org-create $(ORG_NAME) "$(ORG_NAME)" --association_user $(CHEF_USER) --filename $(SRV_PATH)/config/$(ORG_NAME)-validator.pem
	cp /var/opt/opscode/nginx/ca/*.crt $(SRV_PATH)/config/

install-manager:
	# chef manager, a webui
	chef-server-ctl install opscode-manage
	chef-server-ctl reconfigure
	opscode-manage-ctl reconfigure

install-pushjobs:
	# push jobs server: push config changes independently of chef-client run
	chef-server-ctl install opscode-push-jobs-server
	chef-server-ctl reconfigure
	opscode-push-jobs-server-ctl reconfigure

install-replication:
	chef-server-ctl install chef-sync
	chef-server-ctl reconfigure
	chef-sync-ctl reconfigure

install-reporting:
	# reporting
	chef-server-ctl install opscode-reporting
	chef-server-ctl reconfigure
	opscode-reporting-ctl reconfigure

# this target is not generally needed, its only included incase i install chef locally on my desktop
uninstall:
	-chef-server-ctl uninstall
	-rm -rf /root/opscode-cleanse*
	-rm -rf /opt/opscode*
	-rm -rf /opt/chef-sync*
	-rm -rf /etc/opscode*
	-rm -f  /etc/init/opscode-manage-runsvdir.conf
	-rm -rf /etc/chef*
	-rm -rf /etc/chef-sync
	-rm -rf /var/log/opscode*
	-rm -rf /var/opt/opscode*
	-rm -rf /var/chef*
	-rm -rf /var/opt/chef*
	-rm -rf /root/.chef
	-apt-get -y purge chef-server-core
	-apt-get -y purge chef-sync
