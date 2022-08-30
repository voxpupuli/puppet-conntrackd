# puppet-module-conntrackd

Puppet module to manage conntrackd.

[![Build Status](https://github.com/voxpupuli/puppet-conntrackd/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-conntrackd/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-conntrackd/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-conntrackd/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/conntrackd.svg)](https://forge.puppetlabs.com/puppet/conntrackd)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/conntrackd.svg)](https://forge.puppetlabs.com/puppet/conntrackd)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/conntrackd.svg)](https://forge.puppetlabs.com/puppet/conntrackd)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/conntrackd.svg)](https://forge.puppetlabs.com/puppet/conntrackd)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-conntrackd)
[![Apache-2 License](https://img.shields.io/github/license/voxpupuli/puppet-conntrackd.svg)](LICENSE)

Have a look at [`REFERENCE.md`](REFERENCE.md) or the main module class
([`init.pp`](manifests/init.pp)) to see what this module does on a node plus
usage examples.

## Compatibility

Supports both ipv4 and ipv6, all conntrackd options and all sync modes.

Compatible with Debian, Ubuntu and RedHat, Fedora, Centos, Scientific distros.

This module is designed to work with Puppet version 4.10 or newer.

## Requirements

This module has the following dependencies:

* [stdlib](https://forge.puppet.com/puppetlabs/stdlib)
  Version 4.19.0 or newer.

For a full (and up-to-date) list of dependencies, please see
[metadata.json](metadata.json).

## Usage examples

### Install and manage the conntrackd service

```
  include 'conntrackd'
```

### Multicast Sync over eth1 using the default FTFW sync mode:

```
  class { 'conntrackd':
    protocol       => 'Multicast',
    interface      => 'eth1',
    ipv4_address   => $multicast_address,
    ipv4_interface => $facts['networking']['interfaces']['eth1']['ip'],
  }
```

### UDP Sync over eth2 using the ALARM sync mode:

```
  class  { 'conntrackd':
    sync_mode     => 'ALARM',
    protocol      => 'UDP',
    interface     => 'eth2',
    ipv4_address  => $facts['networking']['interfaces']['eth2']['ip'],
    udp_ipv4_dest => $other_remote_host,
  }
```

### Remove service, package and configuration of conntrackd:

```
  class  { 'conntrackd':
    ensure => 'absent',
  }
```

You can find more examples in the examples dir.

## Links

* Official conntrackd website <http://conntrack-tools.netfilter.org/conntrackd.html>
* Official project page <https://github.com/voxpupuli/puppet-conntrackd>

## License, Copyright

See COPYING and NOTICE file in the root directory of this module.

## Author

* Written initially by Ian Bissett <bisscuitt@gmail.com> @bisscuitt
* This module is now maintained by [VoxPupuli](https://voxpupuli.org)
