#!/bin/bash

gatekill ()
{
  status=$(spctl --status)

  if [ "$status" == "assessments enabled" ]; then
    printf "[+] Patching Gatekeeper\n"
    sudo spctl --master-disable
  else
    printf "Gatekeeper alreay patched"
  fi
}

if [ $EUID -eq 0 ]; then
   printf "Please don't run me as root\nThis is a safety feature...I'll request root as needed\n"
   exit
fi

if [ "$2" != "--gatesave" ]; then
  gatekill
fi

if [ "$1" == "-h" ]; then
  printf "Use without paramters to run all defaults\n\n--gatesave Skip Gatekeeper patch\n--hackerman Install pen-testing tools\n-h Show this message\n\n"
  exit
fi

printf "Checking for Homebrew\n"
brew info > /dev/null
if [ $? == 0 ]; then
  printf "Already installed\n"
  printf "[+] Updating Homebrew\n"
  brew update
  brew upgrade
  printf "[+] Pruning\n"
  brew prune
else
  printf "[+] Installing Homebrew\n"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
printf "Checking for Python-3\n"
python3 -V > /dev/null
if [ $? == 0 ]; then
  printf "Already installed\n"
else
  printf "[+] Installing Python-3\n"
  brew install python3
fi
printf "Checking for default pip installation\n"
pip > /dev/null
if [ $? == 0 ]; then
	printf "Already installed\n"
else
	printf "[+] Installing pip\n"
	sudo easy_install pip
fi
printf "[+] Installing dependency packages if needed\n"
pip3 install requests censys termcolor colorama
printf "[+] Installing taps into Homebrew\n"
brew tap caskroom/cask
printf "[+] Installing Nodejs\n"
brew install node
printf "[+] Installing CLI Packages\n"
brew install thefuck
sudo npm install --save trash
sudo npm install --global trash-cli
sudo npm install -g vtop
sudo pip install howdoi
sudo npm install -g tldr
sudo npm install -g now
sudo npm install alex --global
brew install mackup
printf "Install Xcode now (v9+) then press [ENTER] to continue\nIf you don't want to do this now, press [S]\n"
read skip
if [ $skip == S ] || [ $skip == s ]; then
  printf "Skipping Xcode install\n"
  printf "Xcode skipped...MAS will not be installed\n"
else
  xcodebuild -version > /dev/null
  if [ $? == 0 ]; then
    brew install mas
  else
    printf "Xcode could not be found...MAS was not installed\n"
  fi
fi
if [ ! -d "~/Dropbox/" ]; then
  printf "Dropbox not installed...skipping config restore\n"
else
  if [ -d "~/Dropbox/Mackup/" ]; then
    printf "[+] Restoring configs\n"
    mackup restore
  fi
fi
printf "[+] Updating dotfiles\n"
printf "eval $(thefuck --alias)\n" >> ~/.bash_profile
source ~/.bash_profile
if [ ! ~/icloud/ ]; then
  printf "[+] Symlinking folders\n"
  ln -s ~/Library/Mobile\ Documents/com\~apple\~CloudDocs ~/iCloud
fi

if [ "$1" == "--hackerman" ]; then
  printf "[+] Installing Nikto\n"
  brew install nikto
  printf "[+] Installing Nmap\n"
  brew install nmap
  printf "[+] Installing NetCat\n"
  brew install netcat
  printf "[+] Installing SSLsplit\n"
  brew install sslsplit
  printf "[+] Installing Arparp-scan\n"
  brew install arp-scan
  printf "[+] Installing Arpy\n"
  cd
  brew install gource
  pip install pycap pcapy scapy --user
  git clone https://github.com/ivanvza/arpy arpy/
  cd arpy
  git clone https://github.com/dugsong/libdnet.git
  cd libdnet
  ./configure && make
  cd python
  sudo python setup.py install
  cd
  printf "[+] Installing Metasploit\n"
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
  chmod 755 msfinstall
  sudo ./msfinstall
  rm -f msfinstall
  printf "[+] Installing SET\n"
  pip install pyopenssl pefile
  sudo pip install pexpect pycrypto
  git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
  cd setoolkit
  sudo python setup.py install
  printf "\n\n\nSET must be opened once to initiate the configuration file\nPease accept the license then type '99' to exit and return to\nthis script\n"
  read -p "Press [ENTER] to acknowledge and continue"
  sudo python setoolkit
  printf "\n\n\n[+] Patching SET configuration file\n"
  sudo sed -i "" '33s|.*|METASPLOIT_PATH=/opt/metasploit-framework/bin/|' /private/etc/setoolkit/set.config
  if [ $? == 0 ]; then
  	printf "SUCCESS\n"
  else
  	printf "ERROR: Patching SET configuration file failed\n"
  fi
  printf "MSF must be started once to initialize PATH\nShall I do this now?"
  read response
  if [ $response == y ] || [ $response == Y ] || [ $response == yes ]; then
  	cd /opt/metasploit-framework/bin
  	./msfconsole
  else
  	printf "Ok...to initialize your PATH manually, execute './msfconsole'\nfrom '/opt/metasploit-framework/bin'\n"
  fi
  printf "[+] Generating aliases\n"
  printf "alias setoolkit='sudo python $HOME/setoolkit/setoolkit'\n" >> ~/.bash_profile
  printf "alias arpy='sudo python $HOME/arpy/arpy.py'" >> ~/.bash_profile
  source ~/.bash_profile
  printf "\n\n\nFINISHED SETUP\n"
  printf "You may need to reload your terminal, but shouldn't have to\n"
fi

exit
