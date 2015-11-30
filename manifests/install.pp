# Class: netatalk::install
#
class netatalk::install {

    $package_names = $netatalk::params::package_names

    package { $package_names:
        ensure => installed,
    }
}
