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

**Note** that curl and git are requirements for this script to run (see below). 

## Usage

```
Use without paramters to see this message

--run Run default installation script
--gatesave Skip Gatekeeper patch (must always be last parameter)
--hackerman Install pen-testing tools (must always be second parameter)
-h Show this message
```

## FAQ

### So...where does this install shit again?

Mostly this script uses package managers like NPM, Homebrew and Pip to install things and lets them handle paths accordingly. Otherwise, it installs everything into some well organized, neat directories in your `$HOME` directory. Any temporary directories or files created are deleted immediately to keep your system clean. Some aliases are created in your `~/.bash_profile` dotfile. Fork and modify as you see fit to change this workflow style. 

Please note that `rm -Rf` is used at times to speed up the process of deleting temp files. If this troubles you, feel free to modify. An option for deleting directly to the trash instead will be offered in a near-future update utilizing the `trash-cli` tool that is installed with this script. 

### You want me to sudo what???

Actually, I don't want you to sudo anything. Running this script as ROOT will give a very intentional error. Too much ROOT is generally not a good thing in my opinion, so I explicitly wrote this script to only request ROOT when it was specifically needed for the command to function properly. To speed things up and add scriptability, an option will be given in a later update to authorize ROOT only once, but even then, this authorization will only be invoked when needed...superuser privileges will never be required by default just to run the damn thing!

### But I don't like "X" package manager...

Then perhaps this script isn't for you! This uses NPM, Homebrew and Pip(3) liberally on an as needed basis. Only a few things are built directly from source. Some things are downloaded directly using `curl` or cloned using `git`. These are not considered dependencies and are not automatically installed so please be sure your system has them beforehand. In the future, I may expand this to also automatically install GUI apps using Cask (a wonderful Homebrew repo that is installed in this script) and `mas` (a CLI interface to the Mac App Store...still working on automating this part a bit more). 

I use package managers for a number of reasons:

* Ease of scripting and installation of correct, stable versions
* Ease of installation and use since everything is installed and linked properly on the first try
* Ease of management so I don't have to wonder where all my programs are or what they're doing
* Ease of uninstallation should it ever come to such blasphemy

Note: Homebrew is given preference since it is the most stable, respectful and sustainable package manager I've found. 

### I hate this...how can I get rid of it?

An uninstallation option is in the works that will revert the system back to a near clean state. I plan on incorporating four options for this that will do the following:

1. Remove pen-testing tools only
2. Remove pen-testing tools and other third-party CLI packages 
3. Remove everything, including installed frameworks, package managers and repositories, except for symlinks, aliases and dependencies. Some tools that manage configs like Mackup may also remain to avoid problems. 
4. Remove everything and clean up the cruft...this effectively resets your system to before the script was run.  

These options are very much subject to change and may be implimented on a rolling release basis. 

TL;DR: There is currently no easy way to just reset the work done by this script. It runs one and then it's done. You can pretty easily undo anything it does manually, but I understand that's a lot of work. Also please keep in mind this was designed to automate my own workflow as much as possible and as such it can be aggressive with installing things sometimes...if there's a single thing in the script you don't want, modify it before running because it *will* install it. 