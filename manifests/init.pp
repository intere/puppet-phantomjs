
class phantomjs::deps {
  package { 'libfontconfig':
    ensure => 'installed'
  }
}

# Class: phantomjs
#
# This module manages phantomjs
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class phantomjs {
  
  include phantomjs::deps
  
  $TEMP = '/tmp'
  $NAME = 'phantomjs-1.9.0-linux-x86_64'
  $PACKAGE = "$NAME.tar.bz2"
  $URL64BIT = "https://phantomjs.googlecode.com/files/$PACKAGE"
  $TEMPPACKAGE = "$TEMP/$PACKAGE"
  $OPT = '/opt'
  $INSTALLDIR = "$OPT/$NAME"

  exec {
    'get_phantomjs':
      cwd       => "$TEMP",
      command   => "/usr/bin/wget $URL64BIT --output-document=$PACKAGE",
      logoutput => on_failure,
      creates   => "$TEMPPACKAGE";

    'install_phantomjs':
      cwd       => "$OPT",
      command   => "/bin/tar -xjf $TEMPPACKAGE",
      logoutput => on_failure,
      creates   => "$INSTALLDIR",
      require   => [Exec['get_phantomjs'], Class['phantomjs::deps']];
  }

}
