define nagios::commands (
  $ensure        = undef,
  $command_line  = undef,
) {

  nagios_command { $name:
    ensure       => $ensure,
    command_line => $command_line,
    group        => nagios,
    mode         => '0644',
    notify       => Class['nagios::service'],
    owner        => root,
    target       => '/usr/local/etc/nagios/nagios_command.cfg',
  }
}

