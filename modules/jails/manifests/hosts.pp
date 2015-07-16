define jails::hosts (
  $allow_raw_sockets = undef,
  $gate              = undef,
  $host_hostname     = undef,
  $interface         = undef,
  $inumber           = undef,
  $ip4_addr          = undef,
  $mask              = undef,
) {

  file { '/etc/jail.conf':
    ensure  => file,
    content => template('jails/jail.conf.erb'),
    group   => wheel,
    mode    => '0644',
    owner   => root,
  }
}
