class nrpe::services::splunk ( ) {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'splunk.cfg':
    ensure  => file,
    content => template('nrpe/services/splunk.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/splunk.cfg",
  }

  @@nagios_command { "check_http_splunk-${::hostname}":
    command_line => '$USER1$/check_http -H $HOSTADDRESS$ -p 8000 -w 5 -c 10',
  }

  @@nagios_service { "check_http_splunk-${::hostname}":
    check_command       => "check_http_splunk-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'splunk http',
    use                 => 'local-service',
  }

  @@nagios_command { "check_mongod_splunk-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_mongod',
  }

  @@nagios_service { "check_mongod_splunk-${::hostname}":
    check_command       => "check_mongod_splunk-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'mongodb',
    use                 => 'local-service',
  }

  @@nagios_command { "check_splunk-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_splunk',
  }

  @@nagios_service { "check_splunk-${::hostname}":
    check_command       => "check_splunk-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'splunk',
    use                 => 'local-service',
  }
}
