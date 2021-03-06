define nagios::checks (
  $ensure                       = undef,
  $action_url                   = undef,
  $active_checks_enabled        = undef,
  $check_command                = undef,
  $check_freshness              = undef,
  $check_interval               = undef,
  $check_period                 = undef,
  $contacts                     = undef,
  $contact_groups               = undef,
  $display_name                 = undef,
  $event_handler                = undef,
  $event_handler_enabled        = undef,
  $first_notification_delay     = undef,
  $flap_detection_enabled       = undef,
  $flap_detection_options       = undef,
  $freshness_threshold          = undef,
  $high_flap_threshold          = undef,
  $hostgroup_name               = undef,
  $host_name                    = undef,
  $icon_image                   = undef,
  $icon_image_alt               = undef,
  $initial_state                = undef,
  $is_volatile                  = undef,
  $low_flap_threshold           = undef,
  $max_check_attempts           = undef,
  $normal_check_interval        = undef,
  $notes                        = undef,
  $notes_url                    = undef,
  $notification_interval        = undef,
  $notifications_enabled        = undef,
  $notification_options         = undef,
  $notification_period          = undef,
  $obsess_over_service          = undef,
  $passive_checks_enabled       = undef,
  $process_perf_data            = undef,
  $retain_nonstatus_information = undef,
  $retain_status_information    = undef,
  $retry_interval               = undef,
  $service_description          = undef,
  $servicegroups                = undef,
  $stalking_options             = undef,
  $use                          = undef,
) {
  nagios_service { $name:
    ensure                       => $ensure,
    action_url                   => $action_url,
    active_checks_enabled        => $active_checks_enabled,
    check_command                => $check_command,
    check_freshness              => $check_freshness,
    check_interval               => $check_interval,
    check_period                 => $check_period,
    contacts                     => $contacts,
    contact_groups               => $contact_groups,
    display_name                 => $display_name,
    event_handler                => $event_handler,
    event_handler_enabled        => $event_handler_enabled,
    first_notification_delay     => $first_notification_delay,
    flap_detection_enabled       => $flap_detection_enabled,
    flap_detection_options       => $flap_detection_options,
    freshness_threshold          => $freshness_threshold,
    group                        => wheel,
    high_flap_threshold          => $high_flap_threshold,
    hostgroup_name               => $hostgroup_name,
    host_name                    => $host_name,
    icon_image                   => $icon_image,
    icon_image_alt               => $icon_image_alt,
    initial_state                => $initial_state,
    is_volatile                  => $is_volatile,
    low_flap_threshold           => $low_flap_threshold,
    max_check_attempts           => $max_check_attempts,
    mode                         => '0644',
    normal_check_interval        => $normal_check_interval,
    notes                        => $notes,
    notes_url                    => $notes_url,
    notification_interval        => $notification_interval,
    notifications_enabled        => $notifications_enabled,
    notification_options         => $notification_options,
    notification_period          => $notification_period,
    notify                       => Class['nagios::service'],
    obsess_over_service          => $obsess_over_service,
    owner                        => root,
    passive_checks_enabled       => $passive_checks_enabled,
    process_perf_data            => $process_perf_data,
    retain_nonstatus_information => $retain_nonstatus_information,
    retain_status_information    => $retain_status_information,
    retry_interval               => $retry_interval,
    service_description          => $service_description,
    servicegroups                => $servicegroups,
    stalking_options             => $stalking_options,
    target                       => '/usr/local/etc/nagios/nagios_service.cfg',
    use                          => $use,
  }
}

