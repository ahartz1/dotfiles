#!/bin/bash

#------------------------------------------------------------------------------+
# Run browser tests in the specified brower. If no specific test file is       |
# provided, run the entire suite.                                              |
#                                                                              |
# Example use: `browsertests chrome TestFileCest:testFunctionName`             |
#------------------------------------------------------------------------------+
browsertests() {
  if [ $# -eq 0 ]; then
    echo "Exiting... please specify a browser (e.g., chrome)"
    return
  elif [ -z "$2" ]; then
      tests="acceptance"
  else
      tests="tests/acceptance/$2"
  fi
  # Launch the Selenium Server on the local machine
  /usr/bin/java \
    -Dwebdriver.chrome.driver=lib/vendor/chromedriver \
    -jar lib/vendor/managed-packages/netwing/selenium-server-standalone/selenium-server-standalone.jar \
    > tests/results/functional/selenium.log 2>&1 &
  # Delete any failure output files from a previous run
  rm -f tests/_output/*.fail.*
  # Wait for the Selenium server to finish its spin-up
  sleep 1
  # Run the tests
  command="/usr/local/bin/php lib/vendor/managed-packages/bin/codecept run ${tests} --env $1"
  echo "${command}"
  ${command}
  # Wait for the test harness to finish what it's doing
  sleep 1
  # Terminate the Selenium Server launched earlier
  kill -HUP $(ps ax | grep '[s]elenium-server-standalone' | awk '{print $1}')
  # Clean up after ourselves
  unset tests
  unset command
}

#------------------------------------------------------------------------------+
# Print the active ip address                                                  |
#   -v   Print relevant details about the active internet interface            |
#   -vv  Print all details about the active internet interface                 |
#------------------------------------------------------------------------------+
showip() {
  local iface=$(route get 0.0.0.0 2>/dev/null | awk '/interface/ { print $2 }')
  if [ -z "$iface" ]; then
    echo >&2 ":: No interface found"
    return 1;
  fi
  case "$1" in
    -vv)
      ifconfig -v $iface
      ;;
    -v)
      ifconfig -v $iface | awk '/(^'"$iface"')|(inet[^6])|(type)/'
      ;;
    *)
      ifconfig -v $iface | awk '/inet[^6]/ { print $2 }'
      ;;
  esac
}

#------------------------------------------------------------------------------+
# Determine which parameters should be passed to Vim. If the current git branch|
# contains a ticket number and there is a session file that contains that      |
# number, then return it. Failing that, return Session.vim, if it exists.      |
# Failing that, return nothing.                                                |
#------------------------------------------------------------------------------+
vim_branch_arg() {
  # Collect all .vim files with 'Session' in the name in the current directory
  local sessions
  if [[ "$1" == "zsh" ]]; then
    # zsh populates arrays differently than bash
    sessions=("${(@f)$(ls -1 | grep -E 'Session.*\.vim')}")
  else
    sessions=$(ls -1 | grep -E 'Session.*\.vim')
  fi
  if [ -z "${sessions}" ]; then
    return
  fi

  # Parse ticket number from git branch and check if any of the identified file
  # names contain it. Record whether a 'Session.vim' file exists in case we
  # fail to identify a match.
  local ticket_from_git_branch
  ticket_from_git_branch=$(git symbolic-ref --short HEAD 2>/dev/null \
    | sed -E -e 's/.*\/?([A-Z]{2,7}-[0-9]+).*/\1/')
  local has_std_session=0
  local session
  for session in ${sessions}
  do
    if [[ "${session}" =~ "${ticket_from_git_branch}" ]]; then
      echo "-S ${session}"
      return
    elif [[ "${session}" = "Session.vim" ]]; then
      has_std_session=1
    fi
  done

  # If we found a Session.vim, open it
  if [[ ${has_std_session} ]]; then
    echo '-S'
  fi
}

if [[ "$0" =~ bash$ ]]; then
  alias nvimbranch='nvim $(vim_branch_arg)'
  alias vimbranch='vim $(vim_branch_arg)'
else
  alias nvimbranch='nvim $(vim_branch_arg zsh)'
  alias vimbranch='vim $(vim_branch_arg zsh)'
fi
