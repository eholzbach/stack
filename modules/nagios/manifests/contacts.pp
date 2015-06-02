define nagios::contacts (
  $ensure                        = undef,
  $alias                         = undef,
  $contactgroups                 = undef,
  $contact_name                  = undef,
  $email                         = undef,
  $host_notification_commands    = undef,
  $host_notifications_enabled    = undef,
  $host_notification_options     = undef,
  $host_notification_period      = undef,
  $pager                         = undef,
  $service_notification_commands = undef,
  $service_notifications_enabled = undef,
  $service_notification_options  = undef,
  $service_notification_period   = undef,
  $use                           = undef,
) {

  nagios_contact { $name:
    ensure                        => $ensure,
    alias                         => $alias,
    contactgroups                 => $contactgroups,
    contact_name                  => $contact_name,
    email                         => 'null',
    group                         => wheel,
    host_notification_commands    => $host_notification_commands,
    host_notifications_enabled    => $host_notifications_enabled,
    host_notification_options     => $host_notification_options,
    host_notification_period      => $host_notification_period,
    mode                          => '0644',
    notify                        => Class['nagios::service'],
    owner                         => root,
    pager                         => $pager,
    service_notification_commands => $service_notification_commands,
    service_notifications_enabled => $service_notifications_enabled,
    service_notification_options  => $service_notification_options,
    service_notification_period   => $service_notification_period,
    target                        => '/usr/local/etc/nagios/nagios_contact.cfg',
    use                           => 'generic-contact',
  }
}
