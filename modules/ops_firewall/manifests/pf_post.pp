# pf.conf default policy of deny all uniform to all nodes

class ops_firewall::pf_post {
  concat::fragment { '/etc/pf-footer.conf':
    content => template('ops_firewall/pf-footer.conf.erb'),
    target  => '/etc/pf.conf',
  }
}
