#!/bin/bash


#######################
#FUNCTIONS
#######################
inArray()
{
  local argbundle=${1}[@]
  local currentarg=${2}
  for i in ${!argbundle}; do
    if [[ ${i} == ${currentarg} ]]; then
      return 0
    fi
  done
  return 1
}

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

remove ()
{
  if [ "$1" != "1" ] || [ "$1" != "2" ] || [ "$1" != "3" ]; then
    printf "[ERROR] Unknown option\n"
    return
  fi
  brew uninstall nikto
  brew uninstall nmap
  brew uninstall netcat
  brew uninstall sslsplit
  brew uninstall arp-scan
  sudo rm -Rf /opt/
  rm -Rf ~/setoolkit/
  rm -Rf ~/Documents/Tools/
  if [ "$1" == "1" ]; then
    return
  fi
  brew uninstall thefuck
  sudo npm uninstall -g trash
  sudo npm uninstall -g trash-cli
  sudo npm uninstall -g tldr
  #sudo npm uninstall -g now
  sudo npm uninstall -g alex
  sudo npm uninstall -g vtop
  sudo pip uninstall howdoi
  brew uninstall profanity
  if [ "$1" == "2" ]; then
    return
  fi
  pip uninstall pyopenssl pefile
  sudo pip uninstall pexpect pycrypto
  pip3 uninstall requests censys termcolor colorama
  brew uninstall node
  brew uninstall gource
  brew uninstall python3
  brew uninstall python
  rm -Rf ~/iCloud
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  sudo spctl --master-enable
}

getHelp()
{
  printf "Use without paramters to see this message\n\n--run Run default installation script\n| --gatesave Skip Gatekeeper patch (optional)\n| --hackerman Install pen-testing tools (optional)\n--uninstall Show removal options\n-h Show this message\n\n"
  exit
}

main()
{
  printf "Checking for Homebrew\n"
  brew info > /dev/null
  if [ $? == 0 ]; then
    printf "Already installed\n"
    printf "[+] Updating Homebrew\n"
    brew update
    brew upgrade
    printf "[+] Cleaning up Homebrew installation\n"
    brew prune
    brew cleanup
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
  printf "Checking for git\n"
  git --version > /dev/null
  if [ $? == 0 ]; then
    printf "Alredy installed\n"
  else
    printf "[+] Installing git\n"
    brew install git
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
  #sudo npm install -g now
  sudo npm install alex --global
  if [ ! -d ~/Dropbox/ ]; then
    printf "[+] Installing Dropbox\n"
    brew cask install dropbox
    open -a Dropbox
  fi
  printf "[+] Installing localized Python 2\n"
  brew install python
  if [ ! ~/icloud/ ]; then
    printf "[+] Symlinking folders\n"
    ln -s ~/Library/Mobile\ Documents/com\~apple\~CloudDocs ~/iCloud
  fi
  printf "[+] Updating dotfiles\n"
  printf "\neval $(thefuck --alias)\n" >> ~/.bash_profile
  source ~/.bash_profile
}

hackerman()
{
  mkdir ~/Documents/Tools/
  cd ~/Documents/Tools/
  printf "[+] Installing Nikto\n"
  brew install nikto
  printf "[+] Installing Nmap\n"
  brew install nmap
  printf "[+] Installing NetCat\n"
  brew install netcat
  printf "[+] Installing SSLsplit\n"
  brew install sslsplit
  printf "[+] Installing Arp-scan\n"
  brew install arp-scan
  printf "[+] Installing Profanity\n"
  brew install profanity
  printf "[+] Installing Arpy\n"
  brew install gource
  pip install pycap pcapy scapy --user
  git clone https://github.com/ivanvza/arpy arpy/
  cd arpy
  git clone https://github.com/dugsong/libdnet.git
  cd libdnet
  ./configure && make
  cd python
  sudo python setup.py install
  printf "[+] Installing DKMC\n"
  cd ~/Documents/Tools/
  git clone https://github.com/Mr-Un1k0d3r/DKMC
  cd DKMC
  mkdir output
  printf "[+] Installing KnockMail\n"
  cd ~/Documents/Tools/
  git clone https://github.com/4w4k3/KnockMail.git
  cd KnockMail
  #The typo is intentional...there is an error in the repo that the author has yet to solve
  sudo pip2 install -r requeriments.txt
  printf "[+] Installing Red Hawk\n"
  cd ~/Documents/Tools/
  git clone https://github.com/Tuhinshubhra/RED_HAWK
  printf "[+] Installing Sublist3r\n"
  cd ~/Documents/Tools/
  git clone https://github.com/aboul3la/Sublist3r.git
  cd Sublist3r
  sudo pip2 install -r requirements.txt
  printf "[+] Installing V3n0m Scanner\n"
  cd ~/Documents/Tools/
  git clone https://github.com/v3n0m-Scanner/V3n0M-Scanner.git
  cd V3n0m-Scanner
  python3 setup.py install --user
  printf "[+] Installing Credmap\n"
  cd ~/Documents/Tools/
  git clone https://github.com/lightos/credmap.git
  printf "[+] Installing The Harvester\n"
  cd ~/Documents/Tools/
  git clone https://github.com/laramies/theHarvester.git
  printf "[+] Installing Trape\n"
  cd ~/Documents/Tools/
  git clone https://github.com/boxug/trape.git
  cd trape
  sudo pip2 install -r requirements.txt
  printf "[+] Installing Metasploit\n"
  cd
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
  chmod 755 msfinstall
  sudo ./msfinstall
  rm -f msfinstall
  printf "[+] Installing SET\n"
  cd ~/Documents/Tools/
  pip install pyopenssl pefile
  sudo pip install pexpect pycrypto
  git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/
  cd setoolkit
  sudo python setup.py install
  printf "\n\n\nSET must be opened once to initiate the configuration file\nPease accept the license then type '99' to exit and return to\nthis script\n"
  read -p "Press [ENTER] to acknowledge and continue"
  sudo python setoolkit
  printf "\n\n\n[+] Patching SET configuration file\n"
  #SET hates the default Metasploit install location for some reason and requires a patch in its config...this ugly sed command will do that
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
  printf "alias setoolkit='sudo python $HOME/tools/setoolkit/setoolkit'\n" >> ~/.bash_profile
  printf "alias arpy='sudo python $HOME/tools/arpy/arpy.py'\n" >> ~/.bash_profile
  printf "alias msfconsole='/opt/metasploit-framework/bin/msfconsole'\n" >> ~/.bash_profile
  printf "alias msfupdate='/opt/metasploit-framework/bin/msfupdate'\n" >> ~/.bash_profile
  printf "alias msfvenom='/opt/metasploit-framework/bin/msfvenom'\n" >> ~/.bash_profile
  printf "alias tools='cd ~/Documents/Tools/'\n" >> ~/.bash_profile
  source ~/.bash_profile
  printf "\n\n\nFINISHED SETUP\n"
  printf "You may need to reload your terminal, but shouldn't have to\n"
}

startUninstall()
{
  printf "Select your unistallation options from the list below:\n"
  printf "1. Remove pen-testing tools only\n"
  printf "2. Remove pen-testing tools and third party CLI utilities\n"
  printf "3. Remove everything, resetting back to a pre-script state\n"
  printf "4. Exit Uninstaller\n"
  read selection
  if [ "$selection" == "1" ]; then
    remove 1
  elif [ "$selection" == "2" ]; then
    remove 2
  elif [ "$selection" == "3" ]; then
    remove 3
  else
    exit
  fi
}
#######################


if [ $EUID -eq 0 ]; then
   printf "Please don't run me as root\nThis is a safety feature...I'll request root as needed\n"
   exit
fi

if [ $# -eq 0 ]; then
  getHelp
fi


##########################################################################################################
# Right now, priority is given to certain arguments over others, though this will be fixed in the future #
# Currently, arguments are handled as a parsed array...getopts will be preferred in the future and added #
# in a future update. The priority logic is as follows:                                                  #
#                                                                                                        #
# Usage is displayed above all else...this was an intentional safety concern                             #
#                                                                                                        #
# The "hackerman" function will only run if the "--run" flag is called with it...the order doesn't       #
# matter.                                                                                                #
#                                                                                                        #
# "--run" is always executed above "--uninstall" even if "--uninstall" is called first                    #
##########################################################################################################

args=( "$@" )
if inArray args "-h"; then
  getHelp
elif inArray args "--run"; then
  if inArray args "--gatesave"; then
    printf "" > /dev/null
  else
    gatekill
  fi
  if inArray args "--hackerman"; then
    main
    hackerman
  else
    main
  fi
elif inArray args "--uninstall"; then
  startUninstall
else
  printf "Invalid option\n\n"
  getHelp
fi
exit
