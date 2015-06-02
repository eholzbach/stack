# basic puppetmaster

class puppetmaster () {

  $mortal = hiera('mortal')

  exec {'git_init':
    command     => 'git init --bare /opt/puppet.git',
    path        => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
    refreshonly => true,
  }

  file {'/etc/sudoers.d/puppet':
    ensure  => file,
    content => template('puppetmaster/puppet.sudoers.erb'),
    group   => root,
    mode    => '0440',
    owner   => root,
  }

  file {'/opt/puppet.git':
    ensure  => directory,
    group   => $mortal,
    notify  => Exec['git_init'],
    owner   => $mortal,
    require => Package['git'],
  }

  file {'/opt/puppet.git/hooks/post-receive':
    ensure  => file,
    group   => root,
    mode    => '0755',
    owner   => root,
    require => Package['git'],
    source  => 'puppet:///modules/puppetmaster/post-receive',
  }

  package {'git': ensure => installed }
}
