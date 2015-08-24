# pf.conf header, uniform on all nodes

class ops_firewall::pf_pre {
  concat::fragment { '/etc/pf-header.conf':
    content => template('ops_firewall/pf-header.conf.erb'),
    target  => '/etc/pf.conf',
  }
}
