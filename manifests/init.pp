# == Class: alfred
#
# Install and configure Alfred
#
class alfred (
  $package = 'alfred-halyard',
  $install_path = "/Users/${::boxen_user}/Applications/Alfred 2.app",
  $license_src = 'licenses/alfred',
  $license_dst = "/Users/${::boxen_user}/Library/Application Support/Alfred 2/license.plist"
) {
  dropbox::synced_file { $license_src: } ~>
  file { $license_dst:
    ensure  => 'present',
    content => dropbox_file($license_src)
  } ->
  package { $package:
    provider => 'brewcask',
    require  => [
      Homebrew::Tap['halyard/casks'],
      Package['dropbox-halyard']
    ]
  } ->
  osx_login_item { 'Alfred 2':
    hidden => true,
    path   => $install_path
  } ~>
  exec { "launch alfred":
    command     => "/usr/bin/open '${install_path}'",
    refreshonly => true,
  }
}
