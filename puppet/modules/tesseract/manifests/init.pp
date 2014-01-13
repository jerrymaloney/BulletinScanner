# = Class: tesseract
#
# Compiles and installs Tesseract OCR engine.
#
class tesseract inherits tesseract::params {
  require leptonica
  
  package { 'gcc-c++':
    ensure => 'installed',
  }
  package { 'autoconf':
    ensure => 'installed',
  }
  package { 'automake':
    ensure => 'installed',
  }
  package { 'libtool':
    ensure => 'installed',
  }
  exec { 'install tesseract prereqs':
    # this is just a noop wrapper to make dependency management clearer
    command => '/bin/echo "tesseract prereqs installed through package manager"',
    require => [ 
                 Package['gcc-c++'],
                 Package['autoconf'],
                 Package['automake'],
                 Package['libtool'],
               ]
  }
  
  
  /*****************************************************************************
   * COMPILE                                                                   *
   *****************************************************************************/
  exec { 'retrieve tesseract':
    cwd     => "/tmp",
    command => "/usr/bin/wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz -O /tmp/tesseract-ocr-3.02.02.tar.gz",
    creates => "/tmp/tesseract-ocr-3.02.02.tar.gz",
    timeout => 600,
  }
  
  exec { 'untar tesseract':
    cwd     => "/tmp",
    command => "/bin/tar xzf /tmp/tesseract-ocr-3.02.02.tar.gz",
    creates => "/tmp/tesseract-ocr",
    require => Exec['retrieve tesseract'],
  }
  
  exec { 'autogen tesseract':
    cwd     => '/tmp/tesseract-ocr',
    command => '/tmp/tesseract-ocr/autogen.sh',
    creates => '/tmp/tesseract-ocr/config/ltmain.sh',
    require => [ 
                 Exec['install tesseract prereqs'],
                 Exec['untar tesseract'],
               ]
  }
  
  exec { 'configure tesseract':
    cwd     => '/tmp/tesseract-ocr',
    command => '/tmp/tesseract-ocr/configure',
    creates => '/tmp/tesseract-ocr/config.status',
    require => Exec['autogen tesseract'],
  }
  
  exec { 'make tesseract':
    cwd     => '/tmp/tesseract-ocr',
    command => '/usr/bin/make',
    creates => '/tmp/tesseract-ocr/ccmain/adaptations.o',
    require => Exec['configure tesseract'],
    timeout => 900,
  }
  
  exec { 'install tesseract':
    cwd     => '/tmp/tesseract-ocr',
    command => '/usr/bin/make install',
    creates => '/usr/local/bin/tesseract',
    require => Exec['make tesseract'],
  }
  
  exec { 'ldconfig tesseract':
    cwd     => '/tmp/tesseract-ocr',
    command => '/sbin/ldconfig',
    require => Exec['install tesseract'],
  }
  
  
  /*****************************************************************************
   * GET LANGUAGE DATA                                                         *
   * This is the trained model that will enable us to run OCR with no training *
   * of our own.                                                               *
   * https://code.google.com/p/tesseract-ocr/wiki/Compiling#Language_Data      *
   *****************************************************************************/
  exec { "retrieve language data":
    cwd     => "/tmp",
    command => "/usr/bin/wget http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz -O /tmp/tesseract-ocr-3.02.eng.tar.gz",
    creates => "/tmp/tesseract-ocr-3.02.eng.tar.gz",
    timeout => 600,
    require => Exec['install tesseract'],
  }
  
  exec { 'install language data':
    cwd     => "/tmp",
    command => "/bin/tar xzf /tmp/tesseract-ocr-3.02.eng.tar.gz -C /usr/local/share/tessdata/  --strip-components 2",  # strip-components removes the 'tesseract-ocr/tessdata/' from the path inside the tar file
    creates => "/usr/local/share/tessdata/eng.cube.bigrams",
    require => Exec['retrieve language data'],
  }
  
  
  /*****************************************************************************
   * TEST                                                                      *
   * Set up a few files for tests; the tests themselves will be run by a shell *
   * script.                                                                   *
   *****************************************************************************/
  file { '/tmp/jekyll-correct.txt':
    content => template('bulletinscanner/jekyll-correct.txt.erb'),
  }
  file { '/tmp/lazydog-correct.txt':
    content => template('bulletinscanner/lazydog-correct.txt.erb'),
  }
  file { '/tmp/druce-correct.txt':
    content => template('bulletinscanner/druce-correct.txt.erb'),
  }
}
