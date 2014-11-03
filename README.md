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
* [imos-bashrc](#imos-bashrc) ... imos-bashrc is a bash init script.
* [imos-crypt](#imos-crypt) ... imos-crypt encrypts and decrypts files.
* [imos-diskdiff](#imos-diskdiff) ... imos-diskdiff compares disk volumes.
* [imos-install](#imos-install) ... #### Usage
* [imos-passgen](#imos-passgen) ... imos-passgen is a password generator.
* [imos-pokemon](#imos-pokemon) ... imos-pokemon prints the current volume's Pokémon name/ID.
* [imos-start](#imos-start) ... imos-start is a start-up script.
* [imos-stat](#imos-stat) ... imos-stat is a command for stat's compatibility.
* [imos-variables](#imos-variables) ... imos-variables is a source file initializing variables.
* [imosh](#imosh) ... imos is a utility library for BASH.
* [ssh-for-git](#ssh-for-git) ... ssh-for-git runs ssh especially for git.
* [stelnet](#stelnet) ... stelnet is an SSL client.

-----
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

-----
### imos-bashrc
imos-bashrc is a bash init script.

imos-bashrc initializes PS1 and sources init files.

### Usage
```sh
source /usr/imos/bin/imos-bashrc
```

-----
### imos-crypt
imos-crypt encrypts and decrypts files.

#### Usage
```sh
imos-crypt [options] [input output] ...
```



#### Options
##### main options
* --decrypt=false
    * Decrypt files.
* --encrypt=false
    * Encrypt files.
* --password=''
    * Password to use instead.

-----
### imos-diskdiff
imos-diskdiff compares disk volumes.

imos-diskdiff compares disk volumes and list different files.

#### Usage
```sh
imos-diskdiff
```



#### Options
##### main options
* --source='/Volumes/Ditto/'
    * Source volume.
* --target='/'
    * Target volume.

-----
### imos-install
#### Usage
```sh
imos-install
```



#### Options

-----
### imos-passgen
imos-passgen is a password generator.

imos-passgen generates a password based on a master password and a domain, and
copies a password to the clip board if it is not from SSH.

Web interface version is available at: http://imoz.jp/password.html

### Usage
```sh
imos-passgen
```

-----
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

-----
### imos-start
imos-start is a start-up script.

imos-start is a script that should run just after boot programs.  This script
requires the root privilege.

#### Usage
```sh
imos-start
```



#### Options

-----
### imos-stat
imos-stat is a command for stat's compatibility.

imos-stat displays information about a file.  GNU's stat and BSD's stat use
different format, so imos-stat converts GNU's format to BSD's format if
necessary.

#### Usage
```sh
imos-stat --format=<format> <file>
```



#### Options
##### main options
* --format=''
    * Format.
* --use_native_uname=true
    * Use native UNAME instead.

-----
### imos-variables
imos-variables is a source file initializing variables.

imos-variables initializes variables.  Thus, imos-variables must be called
using the source built-in command.  This command prepends the bin directory
where imos-variables exists to the PATH environment vairable.

### Usage
```sh
source imos-variables
```


### Variables
* IMOS_STORAGE
    * IMOS_STORAGE is a persistent directory's absolute path.  Its default
      value is /Volumes/Arceus in Mac OSX and /storage in other operating
      systems.
* IMOS_RESOURCE
    * IMOS_RESOURCE is a directory containing resource files for imos scripts.
      Its default value is an absolute path that is ../resource from the
      directory where the imos-variables command exists.

-----
### imosh
imos is a utility library for BASH.

-----
### ssh-for-git
ssh-for-git runs ssh especially for git.

ssh-for-git uses the GIT_SSH_IDENTITY environment variable to specify an
identity file.  Plus, it specifies StrictHostKeyChecking=no so that git is
not blocked for known_hosts registration.

### Usage
```sh
GIT_SSH=ssh-for-git GIT_SSH_IDENTITY=<identity file> \
    git <command>
```


### Caveat
GIT_SSH_IDENTITY must be specified as an environment variable.

-----
### stelnet
stelnet is an SSL client.

stelnet is used to communicate wit hanother host using the SSL protocol.
stelnet requires the openssl command. If port is not specified, 443 (HTTPS)
is used.

#### Usage
```sh
stelnet host [port]
```



#### Options
##### main options
* --crlf=true
    * Use CRLF instead for new lines.
* --debug=false
    * Show debug information.
* --ssl3=true
    * Use SSL3.


