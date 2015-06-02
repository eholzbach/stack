class backups::server (
  $nfs_host,
  $nfs_share,
  ) {

  $backup_dir  = hiera('backups::server::backup_dir')
  $root_group  = hiera('root_group')
  $usr_bin     = hiera('usr_bin')

  cron { 'nfsbackup':
    ensure  => 'present',
    command => '/root/backup.sh',
    hour    => 1,
    minute  => 0,
    target  => 'root',
    user    => 'root',
    weekday => 0,
  }

  file { '/root/backup.sh':
    ensure  => file,
    content => template('backups/backups.sh.erb'),
    group   => $root_group, 
    mode    => '0700',
    owner   => root,
  }
}
