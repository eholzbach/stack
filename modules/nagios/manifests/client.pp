class nagios::client {

  $monitor_host = str2bool(hiera('nagios::client::monitor_host'))

  if $monitor_host == true {
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
}

