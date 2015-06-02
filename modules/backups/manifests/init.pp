class backups {

  $backups_usr     = hiera('backups_usr')
  $backups_key     = hiera('backups_key')
  $backups_keytype = hiera('backups_keytype')

  ssh_authorized_key { 'backups_key':
    ensure => present,
    key    => $backups_key,
    type   => $backups_keytype,
    user   => $backups_usr,
  }
}
