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
  $package = 'halyard/casks/alfred-halyard'
) {
  package { $package:
    provider => 'brewcask',
    require  => Homebrew::Tap['halyard/casks']
  }
}
