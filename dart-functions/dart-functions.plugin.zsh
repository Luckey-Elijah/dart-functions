#!/bin/bash
autoload -Uz is-at-least

local RED="\033[0;31m"
local BOLD='\033[1m'
local NC='\033[0m' # No Color

_has_dart_installed() {
    if [ -x "$(command -v dart)" ]; then; else
        echo "${RED}'dart' is not available on the current \$PATH.${NC}" >&2
    fi
}

_has_dart_fn_set() {
    if [ -v DART_FUNCTIONS ]; then; else
        echo "${RED}${BOLD}DART_FUNCTIONS${NC}${RED} is not set correctly.${NC}" >&2
    fi
}


function dadd() {
    # check if dart is installed and has variable set
    _has_dart_installed; _has_dart_fn_set;
    # shift
    dart pub add --directory=$DART_FUNCTIONS $@
}

function dfn() {
    # check if dart is installed and has variable set
    _has_dart_installed; _has_dart_fn_set;

    local matcher=$1

    # may not work for file names w/ white space
    local dart_file="$DART_FUNCTIONS/$matcher.dart"

    if [ -f $dart_file ]; then
        # send the remaining args to the dart script
        shift
        dart run --enable-asserts $dart_file $@
    else
        echo "${RED}$dart_file${NC} does not exist." >&2
    fi
}
