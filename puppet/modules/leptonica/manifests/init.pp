# = Class: leptonica
#
# Compiles and installs leptonica. http://www.leptonica.org/source/README.html
#
class leptonica inherits leptonica::params {  # has to inherit instead of require because http://docs.puppetlabs.com/puppet/3/reference/lang_classes.html#appendix-smart-parameter-defaults
  
  package { 'gcc':
    ensure => $gcc_version,
  }
  package { $libpng_packagename:
    ensure => 'installed',
  }
  package { $libjpeg_packagename:
    ensure => 'installed',
  }
  package { $libtiff_packagename:
    ensure => 'installed',
  }
  package { $zlib_packagename:
    ensure => 'installed',
  }
  exec { 'install leptonica prereqs':
    # this is just a noop wrapper to make dependency management clearer
    command => '/bin/echo "leptonica prereqs installed through package manager"',
    require => [ 
                 Package['gcc'],
                 Package[$libpng_packagename],
                 Package[$libjpeg_packagename],
                 Package[$libtiff_packagename],
                 Package[$zlib_packagename],
               ]
  }
  
  /*****************************************************************************
   * COMPILE: http://www.leptonica.org/source/README.html#BUILDING             *
   *****************************************************************************/
  exec { 'retrieve leptonica':
    cwd     => "/tmp",
    command => "/usr/bin/wget http://www.leptonica.org/source/leptonica-1.69.tar.gz -O /tmp/leptonica-1.69.tar.gz",
    creates => "/tmp/leptonica-1.69.tar.gz",
    timeout => 600,
  }
  
  exec { 'untar leptonica':
    cwd     => "/tmp",
    command => "/bin/tar xzf /tmp/leptonica-1.69.tar.gz",
    creates => "/tmp/leptonica-1.69",
    require => Exec['retrieve leptonica'],
  }
  
  exec { 'configure leptonica':
    cwd     => '/tmp/leptonica-1.69',
    command => '/tmp/leptonica-1.69/configure',
    require => [ 
                 Exec['untar leptonica'],
                 Exec['install leptonica prereqs'],
               ]
  }
  
  exec { 'make leptonica':
    cwd     => '/tmp/leptonica-1.69',
    command => '/usr/bin/make',
    creates => '/tmp/leptonica-1.69/src/adaptmap.o',
    require => Exec['configure leptonica'],
    timeout => 900,
  }
  
  exec { 'install leptonica':
    cwd     => '/tmp/leptonica-1.69',
    command => '/usr/bin/make install',
    creates => '/usr/local/lib/liblept.so.3.0.0',
    require => Exec['make leptonica'],
  }
}
