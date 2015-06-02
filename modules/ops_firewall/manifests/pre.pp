# default allow

class ops_firewall::pre {

  Firewall {
    require => undef,
  }

  # Import pre rules from hiera
  $fw_prerules = hiera('ops_firewall::pre')
  create_resources('ops_firewall::rules', $fw_prerules)
}
