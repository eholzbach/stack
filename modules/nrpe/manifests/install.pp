class nrpe::install ( ) {

  $nrpe_pkg = hiera('nrpe_pkg')

  package { $nrpe_pkg:
   ensure => installed,
  }

  if $::operatingsystem == 'FreeBSD' {
    file {'/usr/local/etc/nrpe.d':
      ensure => directory,
    }
  }
}
