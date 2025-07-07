# # conntrackd
#
# @summary This class is able to install or remove conntrackd on a node. It
# manages the status and configuration of the service.
#
# @param ensure
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * The managed software packages are being uninstalled.
#   * Any traces of the packages will be purged as good as possible. This may
#     include existing configuration files. The exact behavior is provider
#     dependent. Q.v.:
#     * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#     * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#
# @param autoupgrade
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Q.v.:
#   * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
#   * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#
# @param status
#   String to define the status of the service. Possible values:
#   * <tt>enabled</tt>: Service is running and will be started at boot time.
#   * <tt>disabled</tt>: Service is stopped and will not be started at boot
#     time.
#   * <tt>running</tt>: Service is running but will not be started at boot time.
#     You can use this to start a service on the first Puppet run instead of
#     the system startup.
#   * <tt>unmanaged</tt>: Service will not be started at boot time and Puppet
#     does not care whether the service is running or not. For example, this may
#     be useful if a cluster management software is used to decide when to start
#     the service plus assuring it is running on the desired node.
#   The singular form ("service") is used for the
#   sake of convenience. Of course, the defined status affects all services if
#   more than one is managed (see <tt>service.pp</tt> to check if this is the
#   case).
#
# @param package The name(s) of the conntrack package(s)
# @param service_name The name of the conntrackd service
# @param service_hasrestart The service `hasrestart` attribute
# @param service_hasstatus The service `hasstatus` attribute
# @param service_pattern The service `pattern` attribute
# @param service_status The service `status` attribute
# @param config_dir Top-level directory for configuration
# @param config_filename Config file name
#
# @param hashsize
#   integer: Number of buckets in the cache hashtable.
#
# @param logfile
#   string:  fully qualified path to the logfile or 'Off'
#            (directory must exist and be writable)
#   values:  <tt>on</tt>, <tt>off</tt>, <tt><path to file></tt>
#
# @param syslog
#   string:  enable syslog logging
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt>
#
# @param lockfile
#   string:  fully qualified path to the lockfile
#
# @param sock_path
#   string:  fully qualified path to the UNIX socket used for configuration
#
# @param ignore_ips_ipv4
#   array:   list of IPv4 addresses to ignore.
#            should include this node's address
#
# @param ignore_ips_ipv6
#   array:   list of IPv4 addresses to ignore.
#            should include this node's address
#
# @param tcp_flows
#   array:   list of flows to monitor
#   allowed: 'ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT'
#
# @param netlinkbuffersize
#   integer: Netlink event socket buffer size
#   Default: <tt>2097152</tt>
#
# @param netlinkbuffersizemaxgrowth
#   integer: The daemon doubles the size of the netlink event socket buffer size
#            if it detects netlink event message dropping . This clause sets the
#            maximum buffer size growth that can be reached.
#
# @param netlinkoverrunresync
#   boolean: If the daemon detects that Netlink is dropping state-change events,
#            it automatically schedules a resynchronization against the Kernel
#            after 30 seconds (default value)
#
# @param netlinkeventsreliable
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#
# @param pollsecs
#   integer: By default, the daemon receives state updates following an
#            event-driven model. You can modify this behaviour by switching to
#            polling mode with the PollSecs clause.
#
# @param eventiterationlimit
#   integer: The daemon prioritizes the handling of state-change events coming
#            from the core. With this clause, you can set the maximum number of
#            state-change events (coming from kernel-space) that the daemon
#            will handle after which it will handle other events coming from the
#            network or userspace
#
# @param sync_mode
#   string:  The syncronisation mode to use
#   values:  one of: <tt>FTFW</tt>, <tt>NOTRACK</tt> or <tt>ALARM</tt>
#
# @param resend_queue_size
#   integer: Size of the resend queue (in objects)
#
# @param ack_window_size
#   integer: acknowledgement window size. If you decrease this
#            value, the number of acknowlegdments increases
#
# @param disable_external_cache
#   boolean: This clause allows you to disable the external cache. Thus,
#            the state entries are directly injected into the kernel
#            conntrack table.
#   values:  one of: <tt>On</tt>, <tt>Off</tt>
#
# @param disable_internal_cache
#   boolean: This clause allows you to disable the internal cache.
#
# @param refresh_time
#   integer: ALARM Mode: If a conntrack entry is not modified in <= 15 seconds,
#            then a message is broadcasted.
#
# @param cache_timeout
#   integer: If we don't receive a notification about the state of
#            an entry in the external cache after N seconds, then
#            remove it.
#
# @param commit_timeout
#   integer: This parameter allows you to set an initial fixed timeout
#            for the committed entries when this node goes from backup
#            to primary.
#
# @param startup_resync
#   If conntrackd should request a complete conntrack
#   table resync against the other node at startup.
#
# @param purge_timeout
#   integer: If the firewall replica goes from primary to backup,
#            the conntrackd -t command is invoked in the script.
#            This command schedules a flush of the table in N seconds.
#
# @param systemd
#   String to Enable/Disable systemd support. Possible values:
#   * <tt>On</tt>: Enable systemd support
#   * <tt>Off</tt>: Disable systemd support
#
# @param protocol
#   string:  The protocol to use for syncing.
#   values:  <tt>Multicast</tt> or <tt>UDP</tt>
#
# @param interface
#   string:  Dedicated physical interface for communicating with the other host.
#   value:   <tt><interface name></tt>
#
# @param ipv4_address
#   string:  Multicast mode only: The multicast address to commuincate over
#   value:   *Must* be set for Multicast mode: <tt><multicast address></tt>
#
# @param ipv4_interface
#   string:  The ip address to bind to for multicast and UDP connections.
#   value:   *Must* be set for Multicast or UDP mode: <tt><ipaddress></tt>
#
# @param mcast_group
#   integer: The multicast group to use for Multicast mode
#
# @param sndsocketbuffer
#   integer: The multicast sender uses a buffer to enqueue the packets
#            that are going to be transmitted.
#
# @param rcvsocketbuffer
#   integer: The multicast receiver uses a buffer to enqueue the packets
#            that the socket is pending to handle.
#
# @param checksum
#   integer: Enable/Disable message checksumming.
#
# @param udp_ipv6_address
#   string:  The IPv6 interface address to bind to in UDP mode
#
# @param udp_ipv4_dest
#   string:  The IPv4 interface of the other node when UDP is enabled
#
# @param udp_ipv6_dest
#   string:  The IPv6 interface of the other node when UDP is enabled
#
# @param udp_port
#   integer: The UDP port to communicate over (should be the same on both nodes)
#
# @param filter_accept_protocols
#   array:   Accept only certain protocols
#   values:  <tt>TCP</tt>, <tt>SCTP</tt>, <tt>DCCP</tt>,
#            <tt>UDP</tt>, <tt>ICMP</tt>, <tt>IPv6-ICMP</tt>
#
# @param filter_from
#   String Where the filtering occurs
#   values:  <tt>Kernelspace</tt>, <tt>Userspace</tt>
#
# @param tcp_window_tracking
#   boolean: TCP state-entries have window tracking disabled by default,
#            you can enable it with this option.
#
# @param expectation_sync
#   on: enable the synchronization of expectations
#   array: enable sync on specified expectations 
#
# @param track_tcp_states
#   array:   The specific TCP states to sync
#
# @param scheduler_type
#   string:  Select a different scheduler for the daemon.
#            See man sched_setscheduler(2) for more information. Using a RT
#            scheduler reduces the chances to overrun the Netlink buffer.
#   values:  <tt>RR</tt>, <tt>FIFO</tt>
#
# @param scheduler_priority
#   integer: scheduler process priority
#   range:   <tt>0</tt> - <tt>99</tt>
#
# @param stats_logfile
#   string:  enable logging of stastics to a file
#   values:  fully qualified path to the statis logfile or 'Off'
#
# @param stats_netlink_reliable
#   boolean: If you want reliable event reporting over Netlink, set on this
#            option. If you set on this clause, it is a good idea to set off
#            NetlinkOverrunResync.
#
# @param stats_syslog
#   string:  enable syslog logging of statistics
#   values:  <tt>on</tt>, <tt>off</tt> or <tt><syslog facility></tt>
#
# @param hashlimit
#   integer: Maximum number of conntracks in table
#   undef: 2x the value of /proc/sys/net/netfilter/nf_conntrack_max
#
# @example Installation, make sure service is running and will be started at boot time:
#     class { 'conntrackd': }
#
# @example Removal/decommissioning:
#     class { 'conntrackd':
#       ensure => 'absent',
#     }
#
# @example Install everything but disable service(s) afterwards
#     class { 'conntrackd':
#       status => 'disabled',
#     }
#
# @author Ian Bissett <mailto:bisscuitt@gmail.com>
#
class conntrackd (
  Enum['present', 'absent']        $ensure = 'present',
  Boolean                          $autoupgrade = false,
  # Workaround for https://github.com/voxpupuli/puppet-lint-trailing_comma-check/issues/16
  # lint:ignore:trailing_comma
  Enum[
    'enabled',
    'disabled',
    'running',
    'unmanaged'
  ]                                $status = 'enabled',
  # lint:endignore
  Array                            $package = [],
  String                           $service_name = 'conntrackd',
  Boolean                          $service_hasrestart = true,
  Boolean                          $service_hasstatus = true,
  String                           $service_pattern = 'conntrackd',
  String                           $service_status = '/usr/bin/pgrep conntrackd >/dev/null',
  String                           $config_dir = '/etc/conntrackd',
  String                           $config_filename = 'conntrackd.conf',
  Integer                          $hashsize = 32768,
  String                           $logfile = 'off',
  String                           $syslog = 'on',
  String                           $lockfile = '/var/lock/conntrack.lock',
  String                           $sock_path = '/var/run/conntrackd.ctl',
  Array                            $ignore_ips_ipv4 = ['127.0.0.1', '192.168.0.1', '10.1.1.1'],
  Array                            $ignore_ips_ipv6 = ['::1'],
  Array                            $tcp_flows = ['ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT'],

  Integer                          $netlinkbuffersize = 2097152,
  Integer                          $netlinkbuffersizemaxgrowth = 8388608,
  String                           $netlinkoverrunresync = 'on',
  String                           $netlinkeventsreliable = 'Off',
  Optional[Integer]                $pollsecs = undef,
  Integer                          $eventiterationlimit = 100,

  Enum['FTFW', 'NOTRACK', 'ALARM'] $sync_mode = 'FTFW',
  Integer                          $resend_queue_size = 131072,
  Integer                          $ack_window_size = 300,
  Enum['On','Off']                 $disable_external_cache = 'Off',
  String                           $disable_internal_cache = 'Off',
  Integer                          $refresh_time = 15,
  Integer                          $cache_timeout = 180,
  Optional[Integer]                $commit_timeout = undef,
  Optional[Enum['yes','no']]       $startup_resync = undef,
  Integer                          $purge_timeout = 60,
  Optional[Enum['On','Off']]       $systemd = undef,

  Enum['Multicast', 'UDP']         $protocol = 'Multicast',
  Optional[String]                 $interface = undef,
  String                           $ipv4_address = '225.0.0.50',
  Optional[String]                 $ipv4_interface = undef,
  String                           $mcast_group = '3780',
  Integer                          $sndsocketbuffer = 1249280,
  Integer                          $rcvsocketbuffer = 1249280,
  String                           $checksum = 'on',
  Optional[String]                 $udp_ipv6_address = undef,
  Optional[String]                 $udp_ipv4_dest = undef,
  Optional[String]                 $udp_ipv6_dest = undef,
  Integer                          $udp_port = 3780,

  Array                            $filter_accept_protocols = ['TCP', 'SCTP', 'DCCP'],

  Enum['Kernelspace','Userspace']  $filter_from = 'Userspace',

  String                           $tcp_window_tracking = 'Off',
  Optional[Conntrackd::Exp_sync]   $expectation_sync = undef,
  Array                            $track_tcp_states = ['ESTABLISHED', 'CLOSED', 'TIME_WAIT', 'CLOSE_WAIT'],

  String                           $scheduler_type = 'FIFO',
  String                           $scheduler_priority = '99',

  Optional[String]                 $stats_logfile = undef,
  String                           $stats_netlink_reliable = 'Off',
  Optional[String]                 $stats_syslog = undef,

  # -- Set the hashlimit to be double the sysctl valueof net.nf_conntrack_max
  #    uses custom fact defined in this module
  Optional[Integer]                $hashlimit                  = undef,
) {
  #### Validate parameters
  if $hashlimit {
    $_hashlimit = $hashlimit
  } elsif $facts['nf_conntrack_max'] {
    $_hashlimit = $facts['nf_conntrack_max'] * 2
  } else {
    $_hashlimit = 131072
  }

  #### Manage actions

  # package
  include conntrackd::package

  # service
  include conntrackd::service

  #### Manage relationships

  if $ensure == 'present' {
    include conntrackd::config

    # we need the software before running a service
    Class['conntrackd::package'] -> Class['conntrackd::config'] ~> Class['conntrackd::service']
  } else {
    # make sure all services are getting stopped before software removal
    Class['conntrackd::service'] -> Class['conntrackd::package']
  }
}
