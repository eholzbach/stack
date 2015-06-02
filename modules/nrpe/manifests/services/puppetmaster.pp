class nrpe::services::puppetmaster ( ) {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'puppetmaster.cfg':
    ensure  => file,
    content => template('nrpe/services/puppetmaster.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/puppetmaster.cfg",
  }

  @@nagios_command { "check_passengerh-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_passengerh',
  }

  @@nagios_service { "check_passengerh-${::hostname}":
    check_command       => "check_passengerh-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'passenger helper',
    use                 => 'local-service',
  }

  @@nagios_command { "check_passengerl-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_passengerl',
  }

  @@nagios_service { "check_passengerl-${::hostname}":
    check_command       => "check_passengerl-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'passenger logger',
    use                 => 'local-service',
  }

  @@nagios_command { "check_passengerw-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_passengerw',
  }

  @@nagios_service { "check_passengerw-${::hostname}":
    check_command       => "check_passengerw-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'passenger watchdog',
    use                 => 'local-service',
  }

  @@nagios_command { "check_puppetdb-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_puppetdb',
  }

  @@nagios_service { "check_puppetdb-${::hostname}":
    check_command       => "check_puppetdb-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'puppetdb',
    use                 => 'local-service',
  }

  @@nagios_command { "check_puppetmaster-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_puppetmaster',
  }

  @@nagios_service { "check_puppetmaster-${::hostname}":
    check_command       => "check_puppetmaster-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'puppetmasterd',
    use                 => 'local-service',
  }

  @@nagios_command { "check_puppet_8140-${::hostname}":
    command_line => '$USER1$/check_http -H $HOSTADDRESS$ -w 5 -c 10 -p 8140 -S -e 400',
  }

  @@nagios_service { "check_puppet_8140-${::hostname}":
    check_command       => "check_puppet_8140-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'puppet port',
    use                 => 'local-service',
  }
}
