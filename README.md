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
* [imos-archive](#imos-archive) ... imos-archive archives/dearchives files.
* [imos-aws](#imos-aws) ... imos-aws calls aws with imos credentails.
* [imos-aws-credentials](#imos-aws-credentials) ... imos-aws-credentials shows AWS credentials.
* [imos-bashrc](#imos-bashrc) ... imos-bashrc is a bash init script.
* [imos-crypt](#imos-crypt) ... imos-crypt encrypts/decrypts files.
* [imos-diskdiff](#imos-diskdiff) ... imos-diskdiff compares disk volumes.
* [imos-docker-run](#imos-docker-run) ... imos-archive archives/dearchives files.
* [imos-install](#imos-install) ... imos-install is a script to configure imos-bin.
* [imos-package](#imos-package) ... imos-package manages binary packages.
* [imos-package-create](#imos-package-create) ... imos-package-create creates a package.
* [imos-package-download](#imos-package-download) ... imos-package-download downloads a file from imos-package.
* [imos-package-run](#imos-package-run) ... imos-package-create creates a package.
* [imos-package-upload](#imos-package-upload) ... imos-package-upload uploads files to package.imoz.jp.
* [imos-passgen](#imos-passgen) ... imos-passgen is a password generator.
* [imos-pokemon](#imos-pokemon) ... imos-pokemon prints the current volume's Pokémon name/ID.
* [imos-start](#imos-start) ... imos-start is a start-up script.
* [imos-stat](#imos-stat) ... imos-stat is a command for stat's compatibility.
* [imos-variables](#imos-variables) ... imos-variables is a source file initializing variables.
* [imosh](#imosh) ... imosh is a utility library for BASH.
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
### imos-archive
imos-archive archives/dearchives files.

### Usage
```sh
imos-crypt [options] [input output] ...
```

-----
### imos-aws
imos-aws calls aws with imos credentails.

### Usage
```sh
imos-aws options...
```

-----
### imos-aws-credentials
imos-aws-credentials shows AWS credentials.

#### Usage
```sh
imos-aws-credentials
```



#### Options

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
imos-crypt encrypts/decrypts files.

imos-crypt encrypts/decrypts files using an embedded password by default.
The embedded password is encrypted with a master password that should be
given by imos.  The installed_password flag makes imos-crypt use the
installed password, which should be installed by imos-start.  The password
flag forces the script to use the password given by the flag.  This script
uses AES-256-CBC to encrypt/decrypt.

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
* --installed_password=false
    * Use the installed password instead.
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
### imos-docker-run
imos-archive archives/dearchives files.

#### Usage
```sh
imos-crypt [options] [input output] ...
```



#### Options
##### main options
* --command='su -'
    * Command to run inside docker.
* --container='ephemeral'
    * Container image to use.
* --interactive=true
    * Enable interactive mode.
* --rebuild=false
    * Re-build a base image.
* --volume='/:/host'
    * Volumes to attach.

-----
### imos-install
imos-install is a script to configure imos-bin.

imos-install configures user directories and installs an installed
password if necessary.  This script requires the root privilege.

#### Usage
```sh
imos-install
```



#### Options

-----
### imos-package
imos-package manages binary packages.

### Usage
```sh
imos-package command [options...]
```


### Command
* help
    * Shows help.
* create
    * Archives files under the current directory with a command, and uploads
      the archive as a binary package.
* run
    * Fetches a package and runs it.
* archive
    * Archives files under the current directory with a command.
* upload
    * Uploads a file to the cloud server.
* download
    * Downloads a file from the cloud server.

### `create` command
* `imos-package create ./a.out --foo --bar`
    * Archives files under the current directory with a command:
      `./a.out --foo --bar`, and uploads the archive.
* `imos-package create --lifetime=permanent bash foo.sh`
    * Archives files under the current directory with a command:
      `bash foo.sh`, and uploads the archive as a permanent archive.

### `upload` command
Uploads a file to the cloud server. If the file's size is bigger than 1MB
(specified by --fragment_size flag), the file will be split into fragments
so as to speed up download/upload processes.

### Dependencies
* create
    * Depends on archive and upload.
* run
    * Depends on download.

-----
### imos-package-create
imos-package-create creates a package.

### Usage
  imos-package-creates [options...] arguments...

-----
### imos-package-download
imos-package-download downloads a file from imos-package.

### Usage
  imos-package-download [options] file...

-----
### imos-package-run
imos-package-create creates a package.

### Usage
  imos-package-creates [options...] arguments...

-----
### imos-package-upload
imos-package-upload uploads files to package.imoz.jp.

### Usage
  imos-package-upload file...

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
imosh is a utility library for BASH.

For more details, see https://github.com/imos/imosh

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


