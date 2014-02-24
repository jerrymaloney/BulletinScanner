class wget($version = '1.9.1') {
  
  exec { 'download':
    command => "/usr/bin/wget http://ftp.gnu.org/gnu/wget/wget-$version.tar.gz -O /tmp/wget-$version.tar.gz", 
    cwd     => '/tmp', 
    creates => "/tmp/wget-$version.tar.gz", 
  }
  
  exec { 'unzip':
    command => "/bin/gunzip < wget-$version.tar.gz | tar -xv", 
    cwd     => '/tmp', 
    creates => "/tmp/wget-$version", 
    require => Exec['download'], 
  }
  
  exec { 'configure':
    command => "/tmp/wget-$version/configure --prefix=/usr", 
    cwd     => "/tmp/wget-$version", 
    creates => "/tmp/wget-$version/Makefile", 
    require => Exec['unzip'], 
  }
  
  exec { 'make':
    command => '/usr/bin/make', 
    cwd     => "/tmp/wget-$version", 
    creates => "/tmp/wget-$version/src/wget", 
    require => Exec['configure'], 
  }
  
  exec { 'install':
    command => '/usr/bin/make install', 
    cwd     => "/tmp/wget-$version", 
    require => Exec['make'], 
  }
}
