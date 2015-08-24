# use puppetlabs-firewall to control iptables

class ops_firewall {

  if $::kernel == 'Linux' {
    # purge unmanaged firewall rules
    resources { 'firewall':
      purge => true
    }

    # enforce order 
    Class['ops_firewall::pre'] -> Class['ops_firewall::mid'] -> Class['ops_firewall::post']

    # declare
    include ops_firewall::pre
    include ops_firewall::mid
    include ops_firewall::post

    if $::operatingsystem == 'Debian' {
      package { 'iptables-persistent': ensure => installed }

      file { '/etc/network/if-pre-up.d/iptables':
        ensure => file,
        group  => root,
        mode   => '0755',
        owner  => root,
        source => 'puppet:///modules/ops_firewall/iptables',
      }
    }
  } elsif $::kernel == 'FreeBSD' {

    # enforce order 
    Class['ops_firewall::pf_pre'] -> Class['ops_firewall::pf_mid'] -> Class['ops_firewall::pf_post']

    # declare
    include ops_firewall::pf_pre
    include ops_firewall::pf_mid
    include ops_firewall::pf_post

    concat { '/etc/pf.conf':
      group  => wheel,
      mode   => '0644',
      notify => Service['pf'],
      owner  => root,
    }

    file { '/etc/pf.blocked.conf':
      ensure => present,
      group  => wheel,
      mode   => '0644',
      owner  => root,
    }

    file { '/etc/pf.whitelist.conf':
      ensure => present,
      group  => wheel,
      mode   => '0644',
      owner  => root,
    }

    service { 'pf':
      ensure => running,
      enable => true,
    }

  } else {
  }
}
