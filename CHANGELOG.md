# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

### Security
- updated rubocop dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418 (@majormoses)

### Breaking Changes
- removed ruby `< 2.1` support (@majormoses)

### Fixed
- metrics-zen.rb: fixed a bug due to using single quotes where string interpolation is necessary (@majormoses)

### Changed
- updated changelog guidelines location (@majormoses)

## [2.0.0] 2017-07-04
### Added
- Ruby 2.3.0 & 2.4.1 testing (@Evesy)

### Fixed
- PR template spelling (@Evesy)

### Breaking Change
- Remove Ruby 1.9 completely (@Evesy)

## [1.0.0] - 2017-05-03
## Breaking Change
- removed ruby 1.9 testing as its really not supported anymore (@majormoses)

## Added
- metrics-xen.rb: added support for xl (@mag009)

## [0.1.0] - 2016-08-16
## Changed
- Updated sensu-plugin dependency from `= 1.2.0` to `~> 1.2.0`

## Added
- metrics-xen.rb: new metric plugin added!


## [0.0.3] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.2] - 2015-06-03
### Fixed
- added binstubs

### Changed
- removed cruft from /lib

## 0.0.1 - 2015-04-30
### Added
- initial release

[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/2.0.0...HEAD
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/0.1.0...1.0.0
[0.1.0]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/0.0.3...0.1.0
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-xen/compare/0.0.1...0.0.2
