Hostname "{{ HOST_NAME }}"

FQDNLookup false
Interval {{ COLLECT_INTERVAL | default("10") }}
Timeout 2
ReadThreads 5

LoadPlugin cpu
LoadPlugin df
LoadPlugin load
LoadPlugin memory

<Plugin memory>
  ValuesAbsolute = true
  ValuesPercentage = true
</Plugin>

LoadPlugin disk
LoadPlugin interface
LoadPlugin uptime
LoadPlugin swap

<Plugin cpu>
  ReportByCpu = {{ REPORT_BY_CPU | default("false") }}
  ReportByState = true
  ValuesPercentage = true
</Plugin>

<Plugin df>
  # expose host's mounts into container using -v /:/host:ro  (location inside container does not matter much)
  # ignore rootfs; else, the root file-system would appear twice, causing
  # one of the updates to fail and spam the log
  FSType rootfs
  # ignore the usual virtual / temporary file-systems
  FSType sysfs
  FSType proc
  FSType devtmpfs
  FSType devpts
  FSType tmpfs
  FSType fusectl
  FSType cgroup
  FSType overlay
  FSType debugfs
  FSType pstore
  FSType securityfs
  FSType hugetlbfs
  FSType squashfs
  FSType mqueue
  MountPoint "/etc/resolv.conf"
  MountPoint "/etc/hostname"
  MountPoint "/etc/hosts"
  IgnoreSelected true
  ReportByDevice false
  ReportReserved true
  ReportInodes true
</Plugin>

<Plugin "disk">
  Disk "/^[hs]d[a-z]/"
  IgnoreSelected false
</Plugin>


<Plugin interface>
  Interface "lo"
  Interface "/^veth.*/"
  Interface "/^docker.*/"
  IgnoreSelected true
</Plugin>

LoadPlugin network

<Plugin network>
        Server "52.11.25.153" "5557"
</Plugin>

