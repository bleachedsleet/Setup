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

**Note** that curl is a requirement for this script to run. 

## Usage

```
Use without paramters to see this message

--run Run default installation script
| --gatesave Skip Gatekeeper patch (optional)
| --hackerman Install pen-testing tools (optional)
--uninstall Show removal options
-h Show this message
```

#### Warning

This script doesn't do a lot of error checking...if something fails, it's likely to halt the script and if you run it again, everything will start over. There's some minor error checking in certain areas (configs won't be restored if Dropbox isn't installed; MAS won't be installed if the proper version of Xcode isn't detected; etc) but for the most part, this is a pretty aggressive script that leaves a lot to chance. I will add some error checking in the future, but honestly, this isn't high on my list. This script works for me as intended and if it doesn't for you, you can go right ahead and modify it for your needs. 

## FAQ

### So...where does this install shit again?

Mostly this script uses package managers like NPM, Homebrew and Pip to install things and lets them handle paths accordingly. Otherwise, it installs everything into some well organized, neat directories in your `$HOME` directory. Any temporary directories or files created are deleted immediately to keep your system clean. Some aliases are created in your `~/.bash_profile` dotfile. Fork and modify as you see fit to change this workflow style. 

Please note that `rm -Rf` is used at times to speed up the process of deleting temp files. If this troubles you, feel free to modify. An option for deleting directly to the trash instead will be offered in a near-future update utilizing the `trash-cli` tool that is installed with this script. 

### You want me to sudo what???

Actually, I don't want you to sudo anything. Running this script as ROOT will give a very intentional error. Too much ROOT is generally not a good thing in my opinion, so I explicitly wrote this script to only request ROOT when it was specifically needed for the command to function properly. To speed things up and add scriptability, an option will be given in a later update to authorize ROOT only once, but even then, this authorization will only be invoked when needed...superuser privileges will never be required by default just to run the damn thing!

### But I don't like "X" package manager...

Then perhaps this script isn't for you! This uses NPM, Homebrew and Pip(3) liberally on an as needed basis. Only a few things are built directly from source. Some things are downloaded directly using `curl` or cloned using `git`. In the future, I may expand this to also automatically install GUI apps using Cask (a wonderful Homebrew repo that is installed in this script) and `mas` (a CLI interface to the Mac App Store...still working on automating this part a bit more). 

I use package managers for a number of reasons:

* Ease of scripting and installation of correct, stable versions
* Ease of installation and use since everything is installed and linked properly on the first try
* Ease of management so I don't have to wonder where all my programs are or what they're doing
* Ease of uninstallation should it ever come to such blasphemy

Note: Homebrew is given preference since it is the most stable, respectful and sustainable package manager I've found. 

### I like some random UNIX system...will this work?

No. Mac only and that's how it will stay. Sorry. 

Porting is theoretically possible, especially with the Linuxbrew project supplanting Homebrew on nix systems, but I will not be the one doing all that nonsense. If that interests you, fork this script and have at it. 

### I hate this...how can I get rid of it?

Run with the `--uninstall` flag and peruse options. Sorry to see you go. 