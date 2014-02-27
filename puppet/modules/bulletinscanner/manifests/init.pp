# = Class: bulletinscanner
#
# Installs Bulletin Scanner
#
class bulletinscanner {
  include bulletinscanner::params
  include tesseract
  
  # install pyton natural language tools
  # fuck pip, that shit don't work. i'll stick with yum.
  package { ['numpy', 'PyYAML', 'python-nltk']: 
    ensure => 'present', 
  }
  
}
