# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Colorise bash prompt
PS1='\[\e[0;32m\]\u@\h \[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

##########################
# Perl related

# Update Perl modules using latest cpanfile
PERLCORE_CPANFILE_DIR=/opt/jscore/build/conf
alias updatepc="PERL5LIB= \
    cpanm --verbose \
    --cpanfile=$PERLCORE_CPANFILE_DIR/cpanfile \
    --local-lib=/opt/jsperlcore/ \
    --installdeps $PERLCORE_CPANFILE_DIR"

function perlmodver {
    perl -M$1 -e 'print "Version ". $ARGV[0]->VERSION ." of ". $ARGV[0] ." is installed \n"' $1
}

# Perl 6 dirs for rakudobrew
export PATH=$PATH:~/.rakudobrew/bin
export PATH=$PATH:/home/developer/.rakudobrew/moar-nom/panda/bin

#########################
# Oracle
export ORACLE_HOME=/usr/lib/oracle/12.1/client64

########################
# Node/NVM
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

########################
# MongoDB
export PATH=$PATH:/opt/mongodb/bin
# Start mongod using: mongod -f /opt/mongodb/mongodb.conf

########################
# Useful bits and pieces 
alias ducks='du -cks * | sort -rn | head'

# Display system info
function sysinfo() {
    cat /proc/cpuinfo | grep 'model name' | head -1 | awk '{ for (i = 4; i <= NF; i++) printf " %s ", $i }'
    printf '\n'
    vmstat -s -S M | head -n 1 | awk '{ print " Memory: " $1 "MB" }'
    cat /etc/issue | awk '{ printf " OS: %s %s %s | ", $1 , $2 , $3}'
    uname -a | awk '{ printf "Kernel: %s " , $3 }'
    uname -m | awk '{ printf "%s | " , $1 }'
    printf '\n'
    uptime
}
