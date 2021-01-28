#!/usr/bin/env bash

# tests - Shellcheck based tests
# =========================================================
# - https://github.com/aaqaishtyaq/dotfiles
# - https://aaqa.dev

set -e
set -o pipefail

ERRORS=()
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# SHELLCHECK Ignore
# SC2034 = foo appears unused. Verify it or export it. "For Powerline Theme"
# SC1090 = Can't follow non-constant source. Use a directive to specify location.
# SC2015 = Note that A && B || C is not if-then-else. C may run when A is true.
# SC2046 = Quote this to prevent word splitting
export SHELLCHECK_OPTS="-e SC2034 -e SC1090 -e SC2015 -e SC2046"

# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' | sort -u); do
    if file "$f" | grep --quiet shell; then
        {
            shellcheck -x "$f" && echo "${GREEN}[OK]: sucessfully linted $f ${RESET}"
        } || {
            # add to errors
            ERRORS+=("$f")
        }
    fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
    echo "No errors, hooray"
else
    echo "${RED} [ERROR] These files failed shellcheck: ${ERRORS[*]} ${RESET}"
    exit 1
fi
