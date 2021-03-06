# generic config for all servers

class baseline () {

  $bin            = hiera('bin')
  $cron           = hiera('cron')
  $mortal         = hiera('mortal')
  $mortal_key     = hiera('mortal_key')
  $mortal_pass    = hiera('mortal_pass')
  $mortal_keytype = hiera('mortal_keytype')
  $pip_name       = hiera('pip_name')
  $root_group     = hiera('root_group')
  $shell          = hiera('shell')
  $sshd_name      = hiera('sshd_name')
  $usr_bin        = hiera('usr_bin')

  augeas { 'sshd_config':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set PermitRootLogin without-password',
      'set PubkeyAuthentication yes',
      'set PasswordAuthentication no',
      'set ChallengeResponseAuthentication no',
      'set UsePAM no',
    ],
    notify  => Service['ssh'],
  }

  cron { 'puppet-agent':
    ensure  => 'present',
    command => "${usr_bin}/puppet agent --onetime --no-daemonize --splay --splaylimit 60 >/dev/null 2>&1",
    minute  => ['30'],
    target  => 'root',
    user    => 'root',
  }

  file { '/etc/motd':
    ensure  => file,
    content => template('baseline/motd.erb'),
    group   => $root_group,
    mode    => '0644',
    owner   => 'root',
  }

  package { 'pip':
    ensure => installed,
    name   => $pip_name,
  }

  package { 'bash':    ensure => latest }
  package { 'curl':    ensure => latest }
  package { 'rsync':   ensure => latest }
  package { 'screen':  ensure => latest }
  package { 'sudo':    ensure => latest }
  package { 'tcpdump': ensure => latest }
  package { 'vim':     ensure => latest }
  package { 'zsh':     ensure => latest }

  if $::kernel == 'FreeBSD' {

    require pkgng

    augeas { 'default_rc_conf':
      context => '/files/etc/rc.conf',
      changes => [
        "set dumpdev '\"NO\"'",
        "set nrpe2_enable '\"YES\"'",
        "set rsyslogd_enable '\"YES\"'",
        "set rsyslogd_pidfile '\"/var/run/syslog.pid\"'",
        "set sshd_enable '\"YES\"'",
        "set syslogd_enable '\"NO\"'",
      ],
    }

    if $::virtual == 'physical' {
      augeas { 'physical_rc_conf':
        context => '/files/etc/rc.conf',
        changes => [
          "set powerd_enable '\"YES\"'",
        ],
      }
    }

    package { 'autoconf': ensure => latest }
    package { 'automake': ensure => latest }
    package { 'gmake':    ensure => latest }
    package { 'help2man': ensure => latest }
    package { 'libtool':  ensure => latest }
    package { 'm4':       ensure => latest }
    package { 'pkgconf':  ensure => latest }
  }

  if $::kernel == 'Linux' {
    package { 'strace':  ensure => latest }
  }

  service { 'cron':
    ensure => running,
    enable => true,
    name   => $cron,
  }

  service { 'ssh':
    ensure => running,
    enable => true,
    name   => $sshd_name,
  }

  ssh_authorized_key { 'non_root_key':
    ensure  => present,
    key     => $mortal_key,
    require => User['non_root'],
    type    => $mortal_keytype,
    user    => $mortal,
  }

  user { 'non_root':
    ensure     => present,
    managehome => true,
    name       => $mortal,
    password   => $mortal_pass,
    shell      => "${bin}/${shell}",
  }

  # CentOS specific 
  if $::operatingsystem == 'CentOS' {
    package { 'epel-release':
      ensure => latest,
      before => Package['pip'],
    }

    package { 'iptables-services': ensure => latest }

    service { 'firewalld':
      ensure => stopped,
      enable => false,
    }
  }

  # meh ssl renewal
  if $::hostname == 'meh' {
    file { '/root/sslrenew.sh':
      ensure => file,
      group  => 'root',
      mode   => '0755',
      owner  => 'root',
      source => 'puppet:///modules/baseline/sslrenew.sh',
    }

    cron { 'renew_ssl':
      ensure  => 'present',
      command => '/root/sslrenew.sh',
      target  => 'root',
      user    => 'root',
      weekday => '0',
    }
  }
}

