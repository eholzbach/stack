filebucket { 'main':
  server => puppet,
}

File { backup => main }

if versioncmp($::puppetversion,'3.6.1') >= 0 {
  Package {
    allow_virtual => true,
  }
}

# if a node definition exists apply this:
hiera_include('classes')

# if a node definition does not exist apply this:
node default {
  hiera_include('classes')
}

if $::operatingsystem == 'FreeBSD' {
  Package {
    provider => pkgng
  }
  pkgng::repo { 'pkg.freebsd.org': }
}
