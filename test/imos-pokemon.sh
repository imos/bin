#!/bin/bash

source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1

system_profiler() {
  if [ "$*" = '-xml -detailLevel full SPSoftwareDataType' ]; then
    cat <<'EOM'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
  <dict>
    <key>_SPCommandLineArguments</key>
    <array>
      <string>/usr/sbin/system_profiler</string>
      <string>-nospawn</string>
      <string>-xml</string>
      <string>SPSoftwareDataType</string>
      <string>-detailLevel</string>
      <string>full</string>
    </array>
    <key>_SPCompletionInterval</key>
    <real>0.0058029890060424805</real>
    <key>_SPResponseTime</key>
    <real>0.12743896245956421</real>
    <key>_dataType</key>
    <string>SPSoftwareDataType</string>
    <key>_detailLevel</key>
    <integer>-2</integer>
    <key>_items</key>
    <array>
      <dict>
        <key>_name</key>
        <string>os_overview</string>
        <key>boot_mode</key>
        <string>normal_boot</string>
        <key>boot_volume</key>
        <string>Pikachu</string>
        <key>kernel_version</key>
        <string>Darwin 14.0.0</string>
        <key>local_host_name</key>
        <string>Ditto</string>
        <key>os_version</key>
        <string>OS X 10.10 (14A389)</string>
        <key>secure_vm</key>
        <string>secure_vm_enabled</string>
        <key>uptime</key>
        <string>up 0:0:53:48</string>
        <key>user_name</key>
        <string>imos (imos)</string>
      </dict>
    </array>
    <key>_parentDataType</key>
    <string>SPRootDataType</string>
    <key>_properties</key>
    <dict>
      <key>boot_mode</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>32</string>
      </dict>
      <key>boot_volume</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>30</string>
        <key>_suppressLocalization</key>
        <string>YES</string>
      </dict>
      <key>kernel_version</key>
      <dict>
        <key>_order</key>
        <string>20</string>
      </dict>
      <key>local_host_name</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>35</string>
      </dict>
      <key>os_version</key>
      <dict>
        <key>_order</key>
        <string>10</string>
      </dict>
      <key>secure_vm</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>50</string>
      </dict>
      <key>server_configuration</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>12</string>
      </dict>
      <key>user_name</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
        <key>_order</key>
        <string>40</string>
      </dict>
      <key>volumes</key>
      <dict>
        <key>_detailLevel</key>
        <string>0</string>
      </dict>
    </dict>
    <key>_timeStamp</key>
    <date>2014-10-26T14:03:27Z</date>
    <key>_versionInfo</key>
    <dict>
      <key>com.apple.SystemProfiler.SPOSReporter</key>
      <string>915</string>
    </dict>
  </dict>
</array>
</plist>
EOM
  else
    LOG FATAL "Unknown flags: $*"
  fi
}

df() {
  if [ "$*" = '/' ]; then
    cat <<'EOM'
Filesystem   512-blocks     Used Available Capacity iused    ifree %iused  Mounted on
/dev/disk0s4  154971144 24244328 130214816    16% 3094539 16276852   16%   /
EOM
  else
    LOG FATAL "Unknown flags: $*"
  fi
}

diskutil() {
  if [ "$*" = 'info -plist /dev/disk0s4' ]; then
    cat <<'EOM'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Bootable</key>
  <true/>
  <key>BusProtocol</key>
  <string>PCI</string>
  <key>CanBeMadeBootable</key>
  <false/>
  <key>CanBeMadeBootableRequiresDestroy</key>
  <false/>
  <key>Content</key>
  <string>Apple_HFS</string>
  <key>DeviceBlockSize</key>
  <integer>512</integer>
  <key>DeviceIdentifier</key>
  <string>disk0s4</string>
  <key>DeviceNode</key>
  <string>/dev/disk0s4</string>
  <key>DeviceTreePath</key>
  <string>IODeviceTree:/PCI0@0/RP06@1C,5/SSD0@0/PRT0@0/PMP@0</string>
  <key>DiskUUID</key>
  <string>3BF55C01-92BC-4714-80C7-D7EE0B280E9F</string>
  <key>Ejectable</key>
  <false/>
  <key>FilesystemName</key>
  <string>Journaled HFS+</string>
  <key>FilesystemType</key>
  <string>hfs</string>
  <key>FilesystemUserVisibleName</key>
  <string>Mac OS Extended (Journaled)</string>
  <key>FreeSpace</key>
  <integer>66661707776</integer>
  <key>GlobalPermissionsEnabled</key>
  <true/>
  <key>IOKitSize</key>
  <integer>79345225728</integer>
  <key>Internal</key>
  <true/>
  <key>JournalOffset</key>
  <integer>2453504</integer>
  <key>JournalSize</key>
  <integer>8388608</integer>
  <key>MediaName</key>
  <string>Pikachu</string>
  <key>MediaType</key>
  <string>Generic</string>
  <key>MountPoint</key>
  <string>/</string>
  <key>ParentWholeDisk</key>
  <string>disk0</string>
  <key>RAIDMaster</key>
  <false/>
  <key>RAIDSlice</key>
  <false/>
  <key>RecoveryDeviceIdentifier</key>
  <string>disk0s5</string>
  <key>SMARTStatus</key>
  <string>Verified</string>
  <key>SolidState</key>
  <true/>
  <key>SupportsGlobalPermissionsDisable</key>
  <true/>
  <key>SystemImage</key>
  <false/>
  <key>TotalSize</key>
  <integer>79345225728</integer>
  <key>VolumeAllocationBlockSize</key>
  <integer>4096</integer>
  <key>VolumeName</key>
  <string>Pikachu</string>
  <key>VolumeUUID</key>
  <string>1B66B181-9AA9-3478-A247-072F82162FD5</string>
  <key>WholeDisk</key>
  <false/>
  <key>Writable</key>
  <true/>
  <key>WritableMedia</key>
  <true/>
  <key>WritableVolume</key>
  <true/>
</dict>
</plist>
EOM
  else
    LOG FATAL "Unknown flags: $*"
  fi
}

readlink() {
  if [ "${#}" -eq 1 ]; then
    local path="$(pwd)/${1}"
    if [ "${path}" = '/Volumes/Pikachu' ]; then
      func::println '/'
    else
      func::println "${path}"
    fi
  else
    LOG FATAL "Wrong number of arguments."
  fi
}

hostname() {
  if [ "$*" = '-i' ]; then
    func::println '153.121.64.206'
  else
    LOG FATAL "Unknown flags: $*"
  fi
}

unset IMOSH_TESTING
source "$(dirname "${BASH_SOURCE}")"/../imos-pokemon || exit 1
