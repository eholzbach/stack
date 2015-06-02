class nrpe::services::apache ( ) {

  $apache_name = hiera('apache_name')  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'apache.cfg':
    ensure  => file,
    content => template('nrpe/services/apache.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/apache.cfg",
  }

  @@nagios_command { "check_apache-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_apache',
  }

  @@nagios_service { "check_apache-${::hostname}":
    check_command       => "check_apache-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'apache pid',
    use                 => 'local-service',
  }

  @@nagios_command { "check_http-${::hostname}":
    command_line => '$USER1$/check_http -H $HOSTADDRESS$ -w 5 -c 10',
  }

  @@nagios_service { "check_http-${::hostname}":
    check_command       => "check_http-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'http',
    use                 => 'local-service',
  }

}
