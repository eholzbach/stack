# use puppetlabs-firewall to control iptables

class ops_firewall {

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
}
