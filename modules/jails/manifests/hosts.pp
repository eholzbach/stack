define jails::hosts (
  $allow_raw_sockets = undef,
  $gate              = undef,
  $host_hostname     = undef,
  $interface         = undef,
  $inumber           = undef,
  $ip4_addr          = undef,
  $mask              = undef,
) {

  concat::fragment { "/etc/jail.conf-${name}":
    content => template('jails/jail.conf.erb'),
    target  => '/etc/jail.conf',
  }
}
