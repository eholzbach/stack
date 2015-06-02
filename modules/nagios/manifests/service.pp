class nagios::service {

  service {'apache24':
    ensure => running,
    enable => true,
  }

  service {'nagios':
    ensure    => running,
    enable    => true,
    subscribe => File['/usr/local/etc/nagios/nagios_command.cfg', '/usr/local/etc/nagios/nagios_contact.cfg',
    '/usr/local/etc/nagios/nagios_host.cfg', '/usr/local/etc/nagios/nagios_hostgroup.cfg', '/usr/local/etc/nagios/nagios_service.cfg'],
  }

  file { ['/usr/local/etc/nagios/nagios_command.cfg', '/usr/local/etc/nagios/nagios_contact.cfg',
    '/usr/local/etc/nagios/nagios_host.cfg', '/usr/local/etc/nagios/nagios_hostgroup.cfg', '/usr/local/etc/nagios/nagios_service.cfg' ]:
    ensure => present,
    group  => wheel,
    mode   => '0644',
    owner  => root,
  }

}

