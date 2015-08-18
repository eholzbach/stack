# old school node defs, will migrate to hiera later

node 'logstash.fightingsquid.net' {
  $logstash_configs = hiera('logstash_configs', {})
  create_resources('logstash::configfile', $logstash_configs)
}

node 'ops1.fightingsquid.net' {

  class { 'graphite':
    gr_timezone        => 'America/Los_Angeles',
    gr_web_server      => 'nginx',
    gr_storage_schemas => [
      {
        name       => 'carbon',
        pattern    => '^carbon\.',
        retentions => '1m:90d',
      },
      {
        name       => 'collectd',
        pattern    => '^collectd\.',
        retentions => '10s:1d,1m:7d,5m:2y',
      },
      {
        name       => 'fitbit',
        pattern    => '^human\.fitbit\.intraday\.*',
        retentions => '1m:20y',
      },
      { 
        name       => 'fitbitsum',
        pattern    => '^human\.fitbit\.summary\.*',
        retentions => '1d:20y',
      },
      {
        name       => 'default',
        pattern    => '.*',
        retentions => '10s:30m,1m:1d,5m:2y',
      }
    ],
  }
}

node 'proteus.fightingsquid.net' {
  tarsnap::periodic { 'devel':
    dirs    => [ '/home/echo/devel' ],
    hour    => 1,
    minute  => 00,
    weekday => 7,
  }

  tarsnap::periodic { 'echo-proteus':
    dirs    => [ '/home/echo' ],
    exclude => [  '/home/echo/.bitcoin', '/home/echo/.litecoin',
                  '/home/echo/media', '/home/echo/.vagrant.d',
                  '/home/echo/VirtualBox\ VMs', '/home/echo/tmp/torrents' ],
    hour    => 1,
    minute  => 00,
    weekday => 7,
  }

}

node 'proxy.fightingsquid.net' {

  $puppetmaster = hiera('puppetmaster')
  $syslogserver = hiera('syslogserver')

  # syslog server
  haproxy::listen { 'syslog_514':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '514',
    mode             => 'tcp',
    options          => {
      'option' => [
      'tcplog',
      ],
    }
  }
  haproxy::balancermember { 'syslog_514':
    listening_service => 'syslog_514',
    ipaddresses       => $syslogserver,
    ports             => '514',
    options           => 'check',
  }

  # puppetmaster
  haproxy::listen { 'puppet_80':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '80',
    mode             => 'tcp',
    options          => {
      'option' => [
      'tcplog',
      ],
    }
  }
  haproxy::balancermember { 'puppet_80':
    listening_service => 'puppet_80',
    ipaddresses       => $puppetmaster,
    ports             => '80',
    options           => 'check',
  }

  haproxy::listen { 'puppet_443':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '443',
    mode             => 'tcp',
    options          => {
      'option' => [
      'tcplog',
      ],
    }
  }
  haproxy::balancermember { 'puppet_443':
    listening_service => 'puppet_443',
    ipaddresses       => $puppetmaster,
    ports             => '443',
    options           => 'check',
  }

  haproxy::listen { 'puppet_8140':
    collect_exported => false,
    ipaddress        => '0.0.0.0',
    ports            => '8140',
    mode             => 'tcp',
    options          => {
      'option' => [
      'tcplog',
      ],
    }
  }
  haproxy::balancermember { 'puppet_8140':
    listening_service => 'puppet_8140',
    ipaddresses       => $puppetmaster,
    ports             => '8140',
    options           => 'check',
  }
}
