# post 

class ops_firewall::post {

  # Import post rules from hiera
  $fw_postrules = hiera('ops_firewall::post')
  create_resources('ops_firewall::rules', $fw_postrules)

}
