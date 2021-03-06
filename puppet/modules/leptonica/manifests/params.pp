# = Class: leptonica params
class leptonica::params {
  
  $gcc_version = $operatingsystemmajrelease ? {
    5 => '4.4.7-4',
    6 => '4.4.7-4.el6',
  }
  
  $libpng_packagename = $::operatingsystem ? {
    /(?i-mx:redhat|centos|fedora|scientific|sl|slc|ascendos|cloudlinux|psbm|oraclelinux|ovs|oel|amazon|xenserver)/ => 'libpng10-devel',    # named libpng12-dev in apt -- maybe this is the cause of 'TODO: png files don't work'?
    /(?i-mx:debian|ubuntu)/                                                                                        => 'libpng12-dev',
    default                                                                                                        => 'libpng12-dev'
  }
  #$libpng_version = $::operatingsystem ? {  TODO
  
  $libjpeg_packagename = $::operatingsystem ? {
    /(?i-mx:redhat|centos|fedora|scientific|sl|slc|ascendos|cloudlinux|psbm|oraclelinux|ovs|oel|amazon|xenserver)/ => 'libjpeg-turbo-devel',
    /(?i-mx:debian|ubuntu)/                                                                                        => 'libjpeg62-dev',
    default                                                                                                        => 'libjpeg62-dev'
  }
  #$libjpeg_version = $::operatingsystem ? {  TODO
  
  $libtiff_packagename = $::operatingsystem ? {
    /(?i-mx:redhat|centos|fedora|scientific|sl|slc|ascendos|cloudlinux|psbm|oraclelinux|ovs|oel|amazon|xenserver)/ => 'libtiff-devel',
    /(?i-mx:debian|ubuntu)/                                                                                        => 'libtiff4-dev',
    default                                                                                                        => 'libtiff4-dev'
  }
  #$libtiff_version = $::operatingsystem ? {  TODO
  
  $zlib_packagename = $::operatingsystem ? {
    /(?i-mx:redhat|centos|fedora|scientific|sl|slc|ascendos|cloudlinux|psbm|oraclelinux|ovs|oel|amazon|xenserver)/ => 'zlib-devel',
    /(?i-mx:debian|ubuntu)/                                                                                        => 'zlib1g-dev',
    default                                                                                                        => 'zlib1g-dev'
  }
  #$zlib_version = $::operatingsystem ? {  TODO
  
}
