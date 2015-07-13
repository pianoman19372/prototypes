chef_server_url          'https://SRV_HOST/organizations/ORG_NAME'
client_key               'SRV_PATH/config/CHEF_USER.pem'

cookbook_copyright       'CHEF_NAME'
cookbook_email           'CHEF_EMAIL'
cookbook_path           ['SRV_PATH/cookbooks']

data_bag_encrypt_version 2

log_level                :debug
log_location             STDOUT

node_name                'CHEF_USER'
syntax_check_cache_path  'USR_PATH/.chef/syntax_check_cache'

validation_client_name   'ORG_NAME-validator'
validation_key           'SRV_PATH/config/ORG_NAME-validator.pem'

knife[:editor] = "vim"
