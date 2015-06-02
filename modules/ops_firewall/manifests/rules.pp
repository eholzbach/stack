# Imports rules from hiera

define ops_firewall::rules (
  $action      = undef,
  $destination = undef,
  $dport       = undef,
  $iniface     = undef,
  $port        = undef,
  $proto       = undef,
  $source      = undef,
  $state       = undef,
) {

  firewall { $name:
    action      => $action,
    destination => $destination,
    dport       => $dport,
    iniface     => $iniface,
    port        => $port,
    proto       => $proto,
    source      => $source,
    state       => $state,
  }
}

