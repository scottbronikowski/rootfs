# Sourced by Xsession(5)

if test -d "$HOME/.keychain"
then
  h="`uname -n 2>/dev/null || echo unknown`"
  keychain --ignore-missing --inherit local-once --noask --nocolor --quick \
    --quiet --host "$h"
  if test -f "$HOME/.keychain/$h-sh"
  then
    . "$HOME/.keychain/$h-sh"
  fi
  if test -f "$HOME/.keychain/$h-sh-gpg"
  then
    . "$HOME/.keychain/$h-sh-gpg"
  fi
fi
