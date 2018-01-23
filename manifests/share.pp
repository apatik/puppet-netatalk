# Define: netatalk::share
#
define netatalk::share (
    $share_path,
    $directory_perm   = false,
    $file_perm        = false,
    $hosts_allow      = false,
    $hosts_deny       = false,
    $valid_users      = false,
    $read_only        = false,
    $rw_list          = false,
    $disconnect_time  = false,
    $time_machine     = false,
    $enable_spotlight = false,
    $cap_limit        = false,
    ) {

    include netatalk

    $config_file = $netatalk::params::config_file

    concat::fragment { "afp.conf-share-${name}":
        target  => $config_file,
        content => template('netatalk/afp.conf.share.erb'),
        require => Class['netatalk::install'],
        notify  => Service['netatalk'],
    }
}
