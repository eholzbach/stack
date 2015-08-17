class nrpe::services::tor () {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'tor.cfg':
    ensure  => file,
    content => template('nrpe/services/tor.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/tor.cfg",
  }

  @@nagios_command { "check_tor-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_tor',
  }

  @@nagios_service { "check_tor-${::hostname}":
    check_command       => "check_tor-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'tor',
    use                 => 'local-service',
  }
}
