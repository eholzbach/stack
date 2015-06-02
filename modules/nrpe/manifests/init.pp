class nrpe ( ) {

 Class['nrpe::install'] -> Class['nrpe::service']

  include nrpe::install
  include nrpe::service
}
