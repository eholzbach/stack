class nrpe::services::graphite ( ) {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'graphite.cfg':
    ensure  => file,
    content => template('nrpe/services/graphite.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/graphite.cfg",
  }

  @@nagios_command { "check_carbon-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_carbon',
  }

  @@nagios_service { "check_carbon-${::hostname}":
    check_command       => "check_carbon-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'carbon',
    use                 => 'local-service',
  }

  @@nagios_command { "check_carbon_2003-${::hostname}":
    command_line => '$USER1$/check_tcp -H $HOSTADDRESS$ -w 5 -c 10 -p 2003',
  }

  @@nagios_service { "check_carbon_2003-${::hostname}":
    check_command       => "check_carbon_2003-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'carbon newline',
    use                 => 'local-service',
  }

  @@nagios_command { "check_carbon_2004-${::hostname}":
    command_line => '$USER1$/check_tcp -H $HOSTADDRESS$ -w 5 -c 10 -p 2004',
  }

  @@nagios_service { "check_carbon_2004-${::hostname}":
    check_command       => "check_carbon_2004-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'carbon pickle',
    use                 => 'local-service',
  }

  @@nagios_command { "check_wsgi-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_wsgi',
  }

  @@nagios_service { "check_wsgi-${::hostname}":
    check_command       => "check_wsgi-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'wsgi',
    use                 => 'local-service',
  }
}
