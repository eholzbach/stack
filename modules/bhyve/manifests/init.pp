# control bhyve nodes

class bhyve {

  augeas { 'loader_conf':
    context => '/files/boot/loader.conf',
    changes => [
      "set vmm_load '\"YES\"'",
      "set nmdm_load '\"YES\"'",
      "set if_bridge_load '\"YES\"'",
      "set if_tap_load '\"YES\"'",
    ],
  }

  augeas { 'rc_conf':
    context => '/files/etc/rc.conf',
    changes => [
      "set cloned_interfaces '\"bridge0 tap0 tap1 tap2 tap3 tap4 tap5 tap6\"'",
      "set ifconfig_bridge0 '\"addm re0 addm tap0 addm tap1 addm tap2 addm tap3 addm tap4 addm tap5 addm tap6\"'",
    ],
  }

  augeas { 'sysctl_conf':
    context => '/files/etc/sysctl.conf',
    changes => [
      'set net.link.tap.up_on_open 1',
    ],
    notify  => Exec['rm_space'],
  }

  # FreeBSD sysctl.conf entries dont get picked up unless
  # the spaces are removed. 
  exec { 'rm_space':
    command     => "/usr/bin/sed -i '' '/^#/! s/ //g' /etc/sysctl.conf",
    refreshonly => true,
  }

  file { '/usr/local/bhyve':
    ensure => directory,
    group  => wheel,
    owner  => root,
  }

  file { '/usr/local/bhyve/iso':
    ensure  => directory,
    group   => wheel,
    owner   => root,
    require => File['/usr/local/bhyve'],
  }

  file { '/usr/local/bhyve/vm':
    ensure  => directory,
    group   => wheel,
    owner   => root,
    require => File['/usr/local/bhyve'],
  }

  file { 'logs.map':
    ensure  => file,
    group   => wheel,
    owner   => root,
    path    => '/usr/local/bhyve/vm/logs.map',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/logs.map',
  }

  file { 'logs.sh':
    ensure  => file,
    group   => wheel,
    mode    => '0755',
    owner   => root,
    path    => '/usr/local/bhyve/vm/logs.sh',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/logs.sh',
  }

  file { 'proxy.map':
    ensure  => file,
    group   => wheel,
    owner   => root,
    path    => '/usr/local/bhyve/vm/proxy.map',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/proxy.map',
  }

  file { 'proxy.sh':
    ensure  => file,
    group   => wheel,
    mode    => '0755',
    owner   => root,
    path    => '/usr/local/bhyve/vm/proxy.sh',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/proxy.sh',
  }

  file { 'puppet.map':
    ensure  => file,
    group   => wheel,
    owner   => root,
    path    => '/usr/local/bhyve/vm/puppet.map',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/puppet.map',
  }

  file { 'puppet.sh':
    ensure  => file,
    group   => wheel,
    mode    => '0755',
    owner   => root,
    path    => '/usr/local/bhyve/vm/puppet.sh',
    require => File['/usr/local/bhyve/vm'],
    source  => 'puppet:///modules/bhyve/puppet.sh',
  }
}
