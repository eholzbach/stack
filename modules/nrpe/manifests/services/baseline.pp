# checks for all nodes

class nrpe::services::baseline ( ) {

  $cron     = hiera('cron')
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')
  $nrpe_pth = hiera('nrpe_pth')
  $nrpe_srv = hiera('nrpe_srv')

  file { 'nrpe_ntpd.cfg':
    ensure  => absent,
    path    => "${nrpe_inc}/ntpd.cfg",
  }

  file { 'baseline.cfg':
    ensure  => file,
    content => template('nrpe/services/baseline.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/baseline.cfg",
  }

  @@nagios_command { "check_collectd-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_collectd',
  }

  @@nagios_service { "check_collectd-${::hostname}":
    check_command       => "check_collectd-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'collectd',
    use                 => 'local-service',
  }

  @@nagios_command { "check_cron-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_cron',
  }

  @@nagios_service { "check_cron-${::hostname}":
    check_command       => "check_cron-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'cron',
    use                 => 'local-service',
  }

  @@nagios_command { "check_disk-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_disk',
  }

  @@nagios_service { "check_disk-${::hostname}":
    check_command       => "check_disk-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'disk',
    use                 => 'local-service',
  }

  @@nagios_command { "check_load-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_load',
  }

  @@nagios_service { "check_load-${::hostname}":
    check_command       => "check_load-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'load',
    use                 => 'local-service',
  }

  # ntpd binds to *, dont run in jails
  if $::virtual != 'jail' {
    @@nagios_command { "check_ntp-${::hostname}":
      command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_ntp',
    }

    @@nagios_service { "check_ntp-${::hostname}":
      check_command       => "check_ntp-${::hostname}",
      contact_groups      => 'admins',
      host_name           => $::hostname,
      service_description => 'ntp',
      use                 => 'local-service',
    }
  }

  @@nagios_command { "check_rsyslogd-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_rsyslogd',
  }

  @@nagios_service { "check_rsyslogd-${::hostname}":
    check_command       => "check_rsyslogd-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'rsyslog',
    use                 => 'local-service',
  }

  @@nagios_command { "check_ssh-${::hostname}":
    command_line => '$USER1$/check_ssh $ARG1$ $HOSTADDRESS$',
  }

  @@nagios_service { "check_ssh-${::hostname}":
    check_command       => "check_ssh-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'ssh',
    use                 => 'local-service',
  }

  @@nagios_command { "check_tprocs-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_total_procs',
  }

  @@nagios_service { "check_tprocs-${::hostname}":
    check_command       => "check_tprocs-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'pid_count',
    use                 => 'local-service',
  }

  @@nagios_command { "check_users-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_users',
  }

  @@nagios_service { "check_users-${::hostname}":
    check_command       => "check_users-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'users',
    use                 => 'local-service',
  }

  @@nagios_command { "check_zombies-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_zombie_procs',
  }

  @@nagios_service { "check_zombies-${::hostname}":
    check_command       => "check_zombies-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'zombies',
    use                 => 'local-service',
  }
}
