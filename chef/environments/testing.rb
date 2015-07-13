name 'testing'
description 'vagrant nodes get provisioned with this ;)'

default_attributes({ })


override_attributes({
    'ubuntu-essentials' => {
        'configure_root' => true,
        'users' => ['vagrant'],
    }
})

cookbook_versions({ })
