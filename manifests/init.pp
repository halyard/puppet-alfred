# == Class: alfred
#
# Full description of class alfred here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class alfred (
  $package = 'halyard/casks/alfred-halyard',
  $install_path = "/Users/${::boxen_user}/Applications/Alfred 2.app"
) {
  package { $package:
    provider => 'brewcask',
    require  => Homebrew::Tap['halyard/casks']
  }  ->
  osx_login_item { 'Alfred 2':
    hidden => true,
    path   => $install_path
  } ~>
  exec { "launch alfred":
    command     => "/usr/bin/open '${install_path}'",
    refreshonly => true,
  }
}
