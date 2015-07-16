class jails (
) {

  $jailhost = hiera('jails::hosts')
  create_resources('jails::hosts', $jailhost)

  augeas { 'jails_loader_conf':
    context => '/files/boot/loader.conf',
    changes => [
      "set if_epair_load '\"YES\"'",
    ],
  }

  augeas { 'jails_rc_conf':
    context => '/files/etc/rc.conf',
    changes => [
      "set jail_enable '\"YES\"'",
    ],
  }
}

