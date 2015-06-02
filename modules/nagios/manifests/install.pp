# install nagios

class nagios::install {

  package { 'apache24': ensure => installed }
  package { 'cnagios': ensure => installed }
  package { 'mod_php56': ensure => installed }
  package { 'nagios': ensure => installed }
  package { 'php56-extensions': ensure => installed }

  file { 'nagios-httpd.conf':
    ensure  => file,
    group   => wheel,
    mode    => '0644',
    notify  => Class['nagios::service'],
    owner   => root,
    path    => '/usr/local/etc/apache24/Includes/nagios-httpd.conf',
    require => Package['apache24'],
    source  => 'puppet:///modules/nagios/nagios-httpd.conf',
  }

  file { 'nagios.cfg':
    ensure  => file,
    group   => wheel,
    mode    => '0644',
    notify  => Class['nagios::service'],
    owner   => root,
    path    => '/usr/local/etc/nagios/nagios.cfg',
    require => Package['nagios'],
    source  => 'puppet:///modules/nagios/nagios.cfg',
  }

  file { 'templates.cfg':
    ensure  => file,
    group   => wheel,
    mode    => '0644',
    notify  => Class['nagios::service'],
    owner   => root,
    path    => '/usr/local/etc/nagios/templates.cfg',
    require => Package['nagios'],
    source  => 'puppet:///modules/nagios/templates.cfg',
  }

  file {'/usr/local/etc/nagios/cgi.cfg':
    ensure  => link,
    require => Package['nagios'],
    target  => '/usr/local/etc/nagios/cgi.cfg-sample',
  }

  file {'/usr/local/etc/nagios/resource.cfg':
    ensure  => link,
    require => Package['nagios'],
    target  => '/usr/local/etc/nagios/resource.cfg-sample',
  }

  file {'/usr/local/etc/nagios/timeperiods.cfg':
    ensure  => link,
    require => Package['nagios'],
    target  => '/usr/local/etc/nagios/objects/timeperiods.cfg-sample',
  }

  file {'/usr/local/etc/nagios/cnagios.help':
    ensure  => link,
    require => Package['cnagios'],
    target  => '/usr/local/etc/nagios/cnagios.help.sample',
  }

  file {'/usr/local/etc/nagios/cnagios.pl':
    ensure  => link,
    require => Package['cnagios'],
    target  => '/usr/local/etc/nagios/cnagios.pl.sample',
  }

  file {'/usr/local/etc/nagios/cnagiosrc':
    ensure  => link,
    require => Package['cnagios'],
    target  => '/usr/local/etc/nagios/cnagiosrc.sample',
  }

}
