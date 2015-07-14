class jails (
) {

  $jailhost = hiera('jails::hosts')
  create_resources('jails::hosts', $jailhost)

  augeas { 'jails_rc_conf':
    context => '/files/etc/rc.conf',
    changes => [
      "set jail_enable '\"YES\"'",
    ],
  }
}

