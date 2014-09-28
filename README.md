# imos-bin
bin directory used by imos.

## How to Install
Install this repository to /usr/imos/bin and configure ${PATH}:
```sh
curl https://raw.githubusercontent.com/imos/bin/master/tool/setup | sudo bash
```

## Commands
### imofs
A command-line tool to backup/restore files and services.

This command is useful especially for programming contests giving an disk
image, and imofs backs up the initial state and restores almost everything.
Directories to backup/restore are specified as TARGETS, and services to
backup/restore are specified as SERVICES.

#### Usage
```sh
imofs [options] command
```


#### Command
* restore
    * Restore files and services.
* backup
    * Backup files and services.

#### Configurations
* /backup/imofs/services
    * Services to backup/restore.  This file is updated when you call
      backup command.
* /backup/imofs/targets
    * Directories to backup/restore.  A directory should not end with "/".


#### Options
##### main options
* --dry_run=false
    * Show what would have been transferred. (Alias: --n)

### imosh
imos is a utility library for BASH.


