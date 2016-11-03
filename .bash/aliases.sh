# aliases go here, e.g.
# alias g='git'

# CONVENIENCE SHORTCUTS
alias ll='ls -lAhGF'
alias lls='ls -FGA1'
alias lll='ls -lAhGF | less'
#alias home='cd ~'
#alias up='cd ..'
alias irb='irb --simple-prompt'
alias gitlog='git log --graph --oneline --decorate --all'
alias lightbkgnd="export GITC='tput setaf 0'"
alias darkbkgnd="export GITC='tput setaf 7'"
alias turnoffipv6="networksetup -setv6off Wi-Fi"
alias turnonipv6="networksetup -setv6automatic Wi-Fi"

# REDEFINING COMMANDS TO AVOID PROBLEMS AND ADD OPTIONS
alias cp='cp -i'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias nano='nano -z'
alias phantomjs='phantomjs --webdriver=4444'
alias rm='rm -i'
alias tmux='tmux -2'
alias tree='tree -CF'
if [ -e /Applications/MAMP/Library/bin/mysql ]; then
	alias mysql='/Applications/MAMP/Library/bin/mysql -u root -p'
fi
if [ `which ctags` > /dev/null ]; then
	alias ctagsphp='ctags -R --fields=+laimS --languages=php'
	alias ctagspy='ctags -R --fields=+laimS --languages=python'
fi

# TESTING ALIASES
alias apitest='php lib/vendor/managed-packages/bin/codecept run api'
alias browsertest='console/func_tests.sh'
alias browsertestchrome='console/func_tests_chrome.sh'
alias browsertestsafari='console/func_tests_safari.sh'
alias buildtests='php lib/vendor/managed-packages/bin/codecept build'
alias codeception='php lib/vendor/managed-packages/bin/codecept run'
alias cover='lib/vendor/managed-packages/phpunit/phpunit/phpunit -c tests/data/phpunit.coverage.xml tests'
alias covertests='lib/vendor/managed-packages/phpunit/phpunit/phpunit -c tests/data/phpunit.coverage.xml tests; console/copy_coverage_results'
alias testall='unit tests; apitest; browsertestchrome'
alias unit='lib/vendor/managed-packages/phpunit/phpunit/phpunit -c tests/data/phpunit.xml'

# PERSONAL SCRIPT ALIASES
alias phplocations='. ~/.dotfiles/myscripts/php_locations.sh'
alias findall='. ~/.dotfiles/myscripts/find_all.sh'

