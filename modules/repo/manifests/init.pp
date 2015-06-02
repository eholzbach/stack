# set up repos

class repo ( ) {

  # install repo
  case $::operatingsystem {
    'Debian', 'Ubuntu': {

      include apt

      apt::source { 'repo':
        allow_unsigned => true,
        location       => 'http://puppet.fightingsquid.net/deb',
      }
    }
    default: { }
  }

  # build repo, assume apache is running
  $repo_host = hiera('repo_host', 'false')

  if $repo_host == true {

    file { [ '/var/www/html/deb', '/var/www/html/deb/dists' ]:
      ensure => directory,
      group  => 'root',
      mode   => '0755',
      owner  => 'root',
    }

    $wheezy_tree = [ '/var/www/html/deb/dists/wheezy', '/var/www/html/deb/dists/wheezy/main',
                     '/var/www/html/deb/dists/wheezy/main/binary-amd64', ]

    $jessie_tree = [ '/var/www/html/deb/dists/jessie', '/var/www/html/deb/dists/jessie/main',
                     '/var/www/html/deb/dists/jessie/main/binary-amd64', ]

    file { $wheezy_tree:
      ensure => 'directory',
      group  => 'root',
      mode   => '0755',
      owner  => 'root',
    }

    file { $jessie_tree:
      ensure => 'directory',
      group  => 'root',
      mode   => '0755',
      owner  => 'root',
    }

    file { '/var/www/html/update_deb.sh':
      ensure => file,
      group  => 'root',
      mode   => '0755',
      owner  => 'root',
      source => 'puppet:///modules/repo/update_deb.sh',
    }
  }
}

