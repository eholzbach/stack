# single use ntp module

class ntp () {

  $ntpdrift = hiera('ntpdrift')
  $ntpn     = hiera('ntpn')

  file { '/etc/ntp.conf':
    ensure  => file,
    content => template('ntp/ntp.conf.erb'),
    group   => $root_group,
    mode    => '0644',
    owner   => root,
  }

  if $::operatingsystem != 'FreeBSD' {
    package { 'ntp':
      ensure => installed,
      before => File['/etc/ntp.conf'],
    }
  }

  if $::virtual != 'jail' {
    service { 'ntpd':
      ensure    => running,
      enable    => true,
      name      => $ntpn,
      require   => File['/etc/ntp.conf'],
      subscribe => File['/etc/ntp.conf'],
    }
  }
}
