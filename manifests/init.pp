# Class: netatalk
#
# This module manages netatalk
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class netatalk (
    $host_name       = false,
    $ad_domain       = false,
    $listen_iface    = false,
    $listen_ip       = false,
    $log_file        = false,
    $log_level       = false,
    $afp_stats       = false,
    $uam_list        = false,
    $guest_account   = false,
    $max_connections = false,
    $login_message   = false,
    $mimic_model     = false,
    ) inherits netatalk::params {

    include netatalk::install
    include netatalk::service
    include netatalk::config

}
