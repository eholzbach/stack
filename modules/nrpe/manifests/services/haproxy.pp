class nrpe::services::haproxy ( ) {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'haproxy.cfg':
    ensure  => file,
    content => template('nrpe/services/haproxy.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/haproxy.cfg",
  }

  @@nagios_command { "check_haproxy-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_haproxy',
  }

  @@nagios_service { "check_haproxy-${::hostname}":
    check_command       => "check_haproxy-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'haproxy',
    use                 => 'local-service',
  }
}
