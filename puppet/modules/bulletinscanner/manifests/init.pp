# = Class: bulletinscanner
#
# Installs Bulletin Scanner
#
class bulletinscanner {
  include bulletinscanner::params
  include tesseract
  
  # set up basics
  group { 'apps':
    ensure => present,
  }
  user { 'scanner':
    ensure  => present,
    groups  => 'apps',
    require => Group['apps'],
  }
  file { '/var/www':
    ensure => 'directory', 
    owner  => 'scanner', 
    group  => 'apps', 
    mode   => 750, 
  }
  
  # install pyton natural language tools
  # fuck pip, that shit don't work. i'll stick with yum.
  package { ['numpy', 'PyYAML', 'python-nltk']: 
    ensure => 'present', 
  }
  
  # install node.js platform for web server
  class { 'nodejs':
    version => 'v0.10.25', 
  }
  
  # deploy application files
  file { '/var/www/bulletinscanner':
    ensure  => 'present', 
    source  => 'puppet:///modules/bulletinscanner', 
    recurse => true, 
    owner   => 'scanner', 
    group   => 'apps', 
    mode    => 755, 
    require => [File['/var/www'], ], 
  }
  
}
