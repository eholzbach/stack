define jails::hosts (
  $allow_raw_sockets = undef,
  $host_hostname     = undef,
  $interface         = undef,
  $ip4_addr          = undef,
) {

  file { '/etc/jail.conf':
    ensure  => file,
    content => template('jails/jail.conf.erb'),
    group   => wheel,
    mode    => '0644',
    owner   => root,
  }
}
