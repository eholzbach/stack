class nrpe::services::nginx () {
  
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_plg = hiera('nrpe_plg')

  file { 'nginx.cfg':
    ensure  => file,
    content => template('nrpe/services/nginx.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    notify  => Class['nrpe::service'],
    owner   => root,
    path    => "${nrpe_inc}/nginx.cfg",
  }

  @@nagios_command { "check_nginx-${::hostname}":
    command_line => '$USER1$/check_nrpe2 -H $HOSTADDRESS$ -c check_nginx',
  }

  @@nagios_service { "check_nginx-${::hostname}":
    check_command       => "check_nginx-${::hostname}",
    contact_groups      => 'admins',
    host_name           => $::hostname,
    service_description => 'nginx',
    use                 => 'local-service',
  }
}
