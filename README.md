# Netatalk Puppet Module


**Table of Contents**

1. [Overview](#overview)
2. [Usage](#usage)
    * [Server configuration](#server-configuration)
    * [Creating shares](#creating-shares)
3. [Examples](#examples)
4. [Requirements](#requirements)
5. [Compatibility](#compatibility)
6. [Known issues](#known-issues)
7. [TODO](#todo)
8. [License](#license)

## Overview
Module for configuring Netatalk v3.x

Tested on CentOS 6.7, CentOS 7.1. Help to support other operating systems is welcome. See `params.pp`

Currently there is no netatalk rpm available from the usual repositories but a source rpm can be obtained from their [wiki](http://netatalk.sourceforge.net/).

Every now and then I publish a final rpm in my blog [https://www.nbalonso.com](https://www.nbalonso.com). Please use the search to find the most recent version.

Default values of the netatalk project are __not__ explained here because they might change in future versions. For that check the documentation [here](http://netatalk.sourceforge.net/3.1/htmldocs/).

Ubuntu users might want to see [this](http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.7_on_Ubuntu_14.10_Utopic) for repacking a recent v3.x version.

## Usage

#### Server configuration
In it's shortest and most boring form just include the class

```ruby
include netatalk
```

Note: If you don't plan to modify the server defaults this is not required. Just define your shares.

All the parameters listed below are optional.

#####`host_name`

Server name to be displayed to clients instead of the server name. Example `host_name => 'Mac Server'`

#####`ad_domain`

Domain to be appended to the username when authenticating. Useful for AD environments that require it

#####`listen_iface`

Name of the network interface to bind. Example `listen_iface => 'eno1'`

#####`listen_ip`

IP address of the network interface to bind. Example `listen_ip => '10.0.0.1'`

#####`log_file`

File where the service should log. Example `log_file => '/var/log/netatalk.log'`

#####`log_level`

Specify how verbose should the log be. Example `log_level => 'default:info'`

#####`afp_stats`

Write message status to the log file. Useful to know about open volumes, sessions... Example `afp_stats => true`

#####`uam_list`

List of user authentication modules. Used to allow empty passwords, kerberos authentication...
Valid values: for guests `uams_guest.so`, Diffie-Hellman key exchange `uams_dhx.so`, Diffie-Hellman key exchange v2 `uams_dhx2.so` and for Kerberos`uam_gss.so`

Example `uam_list => 'uams_guest.so uams_dhx.so uams_dhx2.so uam_gss.so'`

#####`guest_account`

Unix account on the server where the guest will be mapped. Example `guest_account => 'afpguest'`

#####`max_connections`

Number of maximum simultaneous connections. Example `max_connections => 50`

#####`login_message`

Message that will appear on the client when connecting to a volume. Example `login_message => "This is a linux server"`

#####`mimic_model`

Computer icon that will be displayed on the clients' Finder. Example `mimic_model => 'Xserve'`

#### Creating shares
The bare minimum of a share requires a name and a path.
```ruby
netatalk::share { 'My afp share':
    share_path => '/afpshare',
}
```

All other parameters listed below are optional.

#####`hosts_allow`

List of host computers that are allowed to mount the volume.

#####`hosts_deny`

List of hosts that will not be allowed to mount the volume.

#####`valid_users`

List of users allowed to mount the volume. Groups must be preceded by the @ symbol.

#####`read_only`

If set to true the volume will be read only.

#####`rw_list`

Users and/or that are allowed to read and write to the volume.

#####`disconnect_time`

Number of hours to maintain the sessions as disconnected before dropping them.

#####`time_machine`

Wether to allow Time Machine to backup to the volume.

#####`enable_spotlight`

Whether to enable Spotlight searches.

#####`cap_limit`

Limit in MB of the volume. Useful when combined with `time_machine`.

## Examples

```ruby
class { 'netatalk' :
    host_name     => 'Time Capsule',
    listen_iface  => 'eth0',
    log_file      => '/var/log/macbackups.log',
    log_level     => 'default:info',
    afp_stats     => true,
    login_message => 'Backups are limited to 500GB',
    mimic_model   => 'AirPort',
}

netatalk::share { 'Backup':
    share_path   => '/mnt/backups/$u',
    valid_users  => '@users',
    time_machine => true,
    cap_limit    => 5000,
}
```

## Requirements

puppetlabs/concat >= 1.2.0

puppetlabs/stdlib >= 4.2.0

## Compatibility

  * RHEL 6, 7
  * CentOS 6, 7

*Scientific and Oracle are implied*

## Known issues

TBD

## TODO

In no particular order

  * Expose the rest of configuration parameters
  * fill `init.pp`
  * Firewall port 548
  * Kerberos testing. Keytab and all
  * gem auto-testing?
  * Test variable substitutions and explain here
  * SElinux depth tests
  * Module uninstallation
  * Fedora and Ubuntu params

## License

The module itself is released under the all powerful and non-restricting BSD 3 license:

* [https://opensource.org/licenses/BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)
