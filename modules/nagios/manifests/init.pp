# nagios server 

class nagios () {

 Class['nagios::install'] -> Class['nagios::service', 'nagios::import']

  include nagios::install
  include nagios::service
  include nagios::import

  $nagios_checks = hiera('nagios::checks')
  create_resources('nagios::checks', $nagios_checks)

  $nagios_commands = hiera('nagios::commands')
  create_resources('nagios::commands', $nagios_commands)

  $nagios_contacts = hiera('nagios::contacts')
  create_resources('nagios::contacts', $nagios_contacts)

  $nagios_contactgroups = hiera('nagios::contactgroups')
  create_resources('nagios::contactgroups', $nagios_contactgroups)

  $nagios_hosts = hiera('nagios::hosts')
  create_resources('nagios::hosts', $nagios_hosts)

  $nagios_hostgroups = hiera('nagios::hostgroups')
  create_resources('nagios::hostgroups', $nagios_hostgroups)

  resources { [ 'nagios_command', 'nagios_contact', 'nagios_host',
                'nagios_hostgroup', 'nagios_service', ]:
    purge  => true,
  }
}

