class nagios::import {

  Nagios_command <<||>> {
    notify  => Class['nagios::service'],
    require => Class['nagios::install'],
    target  => '/usr/local/etc/nagios/nagios_command.cfg',
  }

  Nagios_host <<||>> {
    notify  => Class['nagios::service'],
    require => Class['nagios::install'],
    target  => '/usr/local/etc/nagios/nagios_host.cfg',
  }

  Nagios_hostgroup <<||>> {
    notify  => Class['nagios::service'],
    require => Class['nagios::install'],
    target  => '/usr/local/etc/nagios/nagios_hostgroup.cfg',
  }

  Nagios_service <<||>> {
    notify  => Class['nagios::service'],
    require => Class['nagios::install'],
    target  => '/usr/local/etc/nagios/nagios_service.cfg',
  }
}
