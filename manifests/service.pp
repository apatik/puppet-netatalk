# Class: netatalk::service
#
class netatalk::service {

    $service_names = $netatalk::params::service_names

    service { $service_names:
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        enable     => true,
        require    => Class['netatalk::install'],
    }

}
