#manually define hostgroups in hiera instead of fighting dup resources

define nagios::hostgroups (
  $ensure            = undef,
  $action_url        = undef,
  $alias             = undef,
  $hostgroup_members = undef,
  $members           = undef,
  $notes             = undef,
  $notes_url         = undef,
) {

  nagios_hostgroup { $name:
    ensure            => $ensure,
    action_url        => $action_url,
    alias             => $alias,
    group             => wheel,
    hostgroup_members => $hostgroup_members,
    members           => $members,
    mode              => '0644',
    notes             => $notes,
    notes_url         => $notes_url,
    notify            => Class['nagios::service'],
    owner             => root,
    target            => '/usr/local/etc/nagios/nagios_hostgroup.cfg',
  }
}

