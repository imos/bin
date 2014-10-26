# imos-bin
bin directory used by imos.

This repository is tested on drone.io (https://drone.io/github.com/imos/bin).

## How to Install/Update
Install this repository to /usr/imos/bin and configure ${PATH}:
```sh
curl https://raw.githubusercontent.com/imos/bin/master/tool/setup | sudo bash
```

Note that you can run the command multiple times safely.

## Commands
* [imofs](#imofs) ... imofs is a command-line tool to backup/restore files and services.
* [imos-pokemon](#imos-pokemon) ... imos-pokemon prints the current volume's Pokémon name/ID.
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

### imos-pokemon
imos-pokemon prints the current volume's Pokémon name/ID.

For Mac OSX, this command uses a disk volume's name to determine Pokémon
ID.  For linux OS, this command uses a primary IP address.

#### Usage
```sh
imos-pokemon [options]
```


#### Files
* /tmp/POKEMON_NAME
    * Cache file to store a Pokémon name.
* ./data/pokemon.txt
    * Mapping from Pokémon ID to Pokémon name.


#### Options
##### main options
* --cache=true
    * Use cache.
* --cache_file='/tmp/POKEMON_NAME'
    * File to cache a Pokémon name
* --id=false
    * Show pokemon ID instead.
* --pokemon_error_level='ERROR'
    * Error level used when resolution partially fails.
* --pokemon_mapping_file='./data/pokemon.txt'
    * File to map a Pokémon ID to a Pokémon name.

### imosh
imos is a utility library for BASH.


