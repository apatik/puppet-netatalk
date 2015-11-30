# Class: netatalk::config
#
class netatalk::config {

    $config_file = $netatalk::params::config_file

    concat { $config_file:
        ensure => present,
        owner  => root,
        group  => root,
        mode   => '0644',
    }

    concat::fragment { 'afp.conf-global':
        target  => $config_file,
        content => template('netatalk/afp.conf.global.erb'),
        require => Class['netatalk::install'],
        notify  => Service['netatalk'],
        order   => 00,
    }

}
