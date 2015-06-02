# collectd

class collectd (
  $basedir,
  $etc_path,
  $host,
  $pkgname,
  $plugindir,
  $prefix,
  $root_group,
  $typesdb,
) {

  $nagios_host = hiera('nagios_host')
 
  package { 'collectd':
    ensure => latest,
    name   => $pkgname,
  }

  if $::operatingsystem == 'CentOS' {
    package { 'collectd-iptables':
      ensure  => latest,
      require => Package['collectd'],
    }

    package { 'collectd-ping':
      ensure  => latest,
      require => Package['collectd'],
    }
  }

  if $::operatingsystem == 'FreeBSD' {
    package { 'libstatgrab': ensure => installed }
  }

  file {'collectd.conf':
    ensure  => file,
    content => template('collectd/collectd.conf.erb'),
    group   => $root_group,
    mode    => '0644',
    notify  => Service['collectd'],
    owner   => root,
    path    => "${etc_path}/collectd.conf",
    require => Package['collectd'],
  }

  service {'collectd':
    ensure  => running,
    enable  => true,
    require => Package['collectd'],
  }
}
