# diamond metric collector

class diamond () {

  require baseline
  require repo

  $etc_path = hiera('etc_path')

  if $::operatingsystem == 'FreeBSD' {
    package { 'diamond':
      ensure   => installed,
      provider => 'pip',
    }->

    file { '/usr/local/etc/diamond':
      ensure => directory,
      group  => root,
      owner  => root,
    }
  } else {
    package { 'diamond':
      ensure => latest,
      notify => Service['diamond'],
    }
  }

  file { 'diamond.conf':
    ensure  => file,
    content => template('diamond/diamond.conf.erb'),
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/diamond.conf",
    require => Package['diamond'],
  }

  file { 'CPUCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/CPUCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/CPUCollector.conf',
  }

  file { 'DiskSpaceCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/DiskSpaceCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/DiskSpaceCollector.conf',
  }

  file { 'DiskUsageCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/DiskUsageCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/DiskUsageCollector.conf',
  }

  file { 'LoadAverageCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/LoadAverageCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/LoadAverageCollector.conf',
  }

  file { 'MemoryCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/MemoryCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/MemoryCollector.conf',
  }

  file { 'NetworkCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/NetworkCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/NetworkCollector.conf',
  }

  file { 'PuppetAgentCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/PuppetAgentCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/PuppetAgentCollector.conf',
  }

  file { 'SockstatCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/SockstatCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/SockstatCollector.conf',
  }

  file { 'TCPCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/TCPCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/TCPCollector.conf',
  }

  file { 'UDPCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/UDPCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/UDPCollector.conf',
  }

  file { 'UsersCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/UsersCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/UsersCollector.conf',
  }

  file { 'VMStatCollector.conf':
    ensure  => file,
    group   => root,
    mode    => '0644',
    notify  => Service['diamond'],
    owner   => root,
    path    => "${etc_path}/diamond/collectors/VMStatCollector.conf",
    require => Package['diamond'],
    source  => 'puppet:///modules/diamond/VMStatCollector.conf',
  }

  service {'diamond':
    ensure  => running,
    enable  => true,
    require => Package['diamond'],
  }

}

