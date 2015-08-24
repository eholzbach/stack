# node specific rules imported from hiera

class ops_firewall::pf_mid {
  $pf_midrules = hiera('ops_firewall::pf_mid')
  concat::fragment { '/etc/pf-mid.conf':
    content => template('ops_firewall/pf-mid.conf.erb'),
    target  => '/etc/pf.conf',
  }
}
