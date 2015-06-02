define nagios::contactgroups (
  $ensure               = undef,
  $alias                = undef,
  $contactgroup_members = undef,
  $members              = undef,
) {

  nagios_contactgroup { $name:
    ensure               => $ensure,
    alias                => $alias,
    contactgroup_members => $contactgroup_members,
    group                => wheel,
    members              => $members,
    mode                 => '0644',
    notify               => Class['nagios::service'],
    owner                => root,
    target               => '/usr/local/etc/nagios/nagios_contactgroup.cfg',
  }
}

