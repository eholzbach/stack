# node specific allow

class ops_firewall::mid {

  Firewall {
    require => undef,
  }

  # Import node specific rules from hiera
  $fw_rules = hiera('ops_firewall::rules')
  create_resources('ops_firewall::rules', $fw_rules)
}
