class nrpe::install ( ) {

  $nrpe_pkg = hiera('nrpe_pkg')

  package { $nrpe_pkg:
   ensure => installed,
  }

  if $::operatingsystem == 'FreeBSD' {
    file {'/usr/local/etc/nrpe.d':
      ensure => directory,
    }

    augeas { 'rc_conf':
      context => '/files/etc/rc.conf',
      changes => [
        "set nrpe2_enable '\"YES\"'",
      ],
    }
  }
}
