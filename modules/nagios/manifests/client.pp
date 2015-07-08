class nagios::client {

  @@nagios_host {"${::hostname}":
    ensure                => present,
    address               => $::ipaddress,
    group                 => wheel,
    hostgroups            => "${::virtual}, ${::kernel}",
    mode                  => '0644',
    notifications_enabled => $notifications_enabled,
    owner                 => root,
    use                   => 'generic-server',
  }
}

