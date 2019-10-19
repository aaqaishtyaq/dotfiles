#!/bin/bash

set -e
set -o pipefail

ERRORS=()
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)


# find all executables and run `shellcheck`
for f in $(find . -type f -not -iwholename '*.git*' | sort -u); do
    if file "$f" | grep --quiet shell; then
        {
            shellcheck "$f" && echo "${GREEN}[OK]: sucessfully linted $f ${RESET}"
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
