# imos-bin
bin directory used by imos.

## How to Install/Update
Install this repository to /usr/imos/bin and configure ${PATH}:
```sh
curl https://raw.githubusercontent.com/imos/bin/master/tool/setup | sudo bash
```

Note that you can run the command multiple times safely.

## Commands
* [imofs](#imofs) ... imofs is a command-line tool to backup/restore files and services.
* [imosh](#imosh) ... imos is a utility library for BASH.

### imofs
imofs is a command-line tool to backup/restore files and services.

This command is useful especially for programming contests giving a disk
image, and imofs backs up the initial state and restores almost everything.
Directories to backup/restore are specified as TARGETS, and services to
backup/restore are specified as SERVICES.

#### Usage
```sh
imofs [options] command
```


#### Command
* restore
    * Restore files and services from FLAGS_backup_directory to
      FLAGS_target_directory.
* backup
    * Backup files and services from FLAGS_target_directory to
      FLAGS_backup_directory.
* deploy
    * Restore files and services from FLAGS_backup_directory to
      FLAGS_target_directory, and deploy files from FLAGS_source_directory to
      FLAGS_target_directory.

#### Configurations
* /backup/imofs/services
    * Services to backup/restore.  This file is updated when you call
      backup command.
* /backup/imofs/targets
    * Directories to backup/restore.  A directory should not end with "/".


#### Options
##### main options
* --backup_directory='/backup'
    * Directory to store backups.
* --dry_run=false
    * Show what will be copied. (Alias: --n)
* --source_directory='.'
    * Source directory to deploy from.
* --target_directory=''
    * Directory to backup/restore.

### imosh
imos is a utility library for BASH.


