# tor
class tor () {
  package { 'tor':      ensure => installed }

  file { '/etc/tor/torrc':
    ensure  => file,
    content => template('tor/torrc.erb'),
    group   => root,
    mode    => '0644',
    notify  => Service['tor'],
    owner   => root,
  }

  service { 'tor':
    ensure  => running,
    enable  => true,
    require => Package['tor'],
  }
}
