# Setup

I wrote this as a personal setup script for my Mac. You might find it useful too.

It installs a number of useful utilities by default but can also install some more specialized items if required. Please look over the code to see what it installs fully, but here are a few things it can do: 

* Installs Homebrew and a few good repos or updates and cleans it up if it's already installed
* Sets up Python and Pip on a fresh system
* Installs Nodejs and a number of really good CLI tools
* Installs Mackup and restores configs if they exist
* Symlinks iCloud Drive for easier access from the CLI
* "Patches" Gatekeeper so you can install software from anywhere on El Capitan or higher systems
* Properly sets up Metasploit and SET so they are immediately useable with an alias
* Respects system privileges and only requests ROOT when needed

## Installation 

Just make the script executable and you're good to go!

```
chmod +x setup.sh
```

## Usage

```
Use without paramters to run all defaults

--gatesave Skip Gatekeeper patch
--hackerman Install pen-testing tools
-h Show this message
```

### So...where does this install shit again?

Mostly this script uses package managers like NPM, Homebrew and Pip to install things and lets them handle paths accordingly. Otherwise, it installs everything into some well organized, neat directories in your `$HOME` directory. Any temporary directories or files created are deleted immediately to keep your system clean. Some aliases are created in your `~/.bash_profile` dotfile. Fork and modify as you see fit to change this workflow style. 

Please note that `rm -Rf` is used at times to speed up the process of deleting temp files. If this troubles you, feel free to modify. An option for deleting directly to the trash instead will be offered in a near-future update utilizing the `trash-cli` tool that is installed with this script. 

### You want me to sudo what???

Actually, I don't want you to sudo anything. Running this script as ROOT will give a very intentional error. Too much ROOT is generally not a good thing in my opinion, so I explicitly wrote this script to only request ROOT when it was specifically needed for the command to function properly. To speed things up and add scriptability, an option will be given in a later update to authorize ROOT only once, but even then, this authorization will only be invoked when needed...superuser privileges will never be required by default just to run the damn thing!