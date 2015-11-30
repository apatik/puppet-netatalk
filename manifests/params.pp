# Class: netatalk::params
#
class netatalk::params {


    case $::osfamily {

        'Redhat': {
            $config_file   = '/etc/netatalk/afp.conf'
            $package_names = ['netatalk', 'avahi', 'dbus']
            $service_names = ['netatalk', 'avahi-daemon', 'messagebus']
        }

        default: { fail("${::osfamily} is not supported by this module.") }

  }

}
