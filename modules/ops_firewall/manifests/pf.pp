define ops_firewall::pf (
  $from  = undef,
  $port  = undef,
  $proto = undef,
) {

  concat::fragment { "/etc/pf.conf-${name}":
    content => template('ops_firewall/pf.conf.erb'),
    target  => '/etc/pf.conf',
  }
}
