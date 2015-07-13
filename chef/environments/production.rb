name 'production'
description 'i dont always test my code, but when i do ...'

default_attributes({

})

override_attributes({
    'ubuntu-essentials' => {
        'configure_root' => true,
        'users' => ['edl'],
    }
})

cookbook_versions({
    'ubuntu-essentials' => '= 0.1.0',
})
