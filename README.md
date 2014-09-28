# imos-bin
bin directory used by imos.

## How to Install
Install this repository to /usr/imos/bin and configure /Users/imos/google-cloud-sdk/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/bootstrap/bin:/bootstrap/bin/darwin:/bootstrap/bin/darwin-x86_64:/usr/local/Cellar/go/1.2.1/libexec/bin:


## Commands
### imofs
A command-line tool to backup/restore files and services.

This command is useful especially for programming contests giving an disk
image, and imofs backs up the initial state and restores almost everything.
Directories to backup/restore are specified as TARGETS, and services to
backup/restore are specified as SERVICES.

#### Configuration
- /backup/imofs/services ...
      Services to backup/restore.  This file is updated when you call
      backup command.
- /backup/imofs/targets ...
      Directories to backup/restore.  A directory should not end with "/".


### imosh
imos is a utility library for BASH.


