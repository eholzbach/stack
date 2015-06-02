class nrpe::service ( ) {

  $nagios_host = hiera('nagios_host')
  $nrpe_grp = hiera('nrpe_grp')
  $nrpe_inc = hiera('nrpe_inc')
  $nrpe_osg = hiera('nrpe_osg')
  $nrpe_pid = hiera('nrpe_pid')
  $nrpe_pkg = hiera('nrpe_pkg')
  $nrpe_plg = hiera('nrpe_plg')
  $nrpe_pth = hiera('nrpe_pth')
  $nrpe_srv = hiera('nrpe_srv')
  $nrpe_usr = hiera('nrpe_usr')

  file { 'nrpe.cfg':
    ensure  => file,
    content => template('nrpe/nrpe.cfg.erb'),
    group   => $nrpe_osg,
    mode    => '0644',
    owner   => root,
    path    => "${nrpe_pth}/nrpe.cfg",
    notify  => Service['nrpe'],
  }

  service {'nrpe':
    ensure     => running,
    enable     => true,
    name       => $nrpe_srv,
    subscribe  => File['nrpe.cfg'],
  }
}
