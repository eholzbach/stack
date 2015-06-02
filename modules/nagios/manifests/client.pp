class nagios::client {

#  $nag_icon = hiera('nag_icon')

  @@nagios_host {"${::hostname}":
    ensure                => present,
    address               => $::ipaddress,
    group                 => wheel,
    hostgroups            => "${::virtual}, ${::kernel}",
#    icon_image            => $nag_icon,
    mode                  => '0644',
    notifications_enabled => $notifications_enabled,
    owner                 => root,
    use                   => 'generic-server',
  }
}

