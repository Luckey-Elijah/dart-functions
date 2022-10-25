autoload -Uz is-at-least

GREEN='\033[0;32m'
RED="\033[0;31m"
NC='\033[0m' # No Color

function _has_dart_installed() {
    if [ -f $(which dart) ]; then
        return 0
    else
        echo "${RED}'dart' is not available on the current \$PATH.${NC} 👎"
        return 1
    fi
}

function _has_dart_fn_set() {
    if [ -d $DART_FUNCTIONS ]; then
        return 0
    else
        echo "${RED}\$DART_FUNCTIONS is not set correctly.${NC} 👎"
        echo "Add ${RED}DART_FUNCTIONS=\"\$HOME/path/to/dart/functions\"${NC} to your ~/.zshrc"
        return 1
    fi
}

function _dart_fn_assert() {
    if _has_dart_installed; then
        if _has_dart_fn_set; then
            return 0
        else
            return 1
        fi
    fi
    return 1
}

function dfn() {
    _dart_fn_assert
    matcher=$1
    dart_file="$DART_FUNCTIONS/$matcher.dart"
    if [ -f $dart_file ]; then
        shift
        dart run $dart_file $@
    else
        echo "${RED}$dart_file${NC} does not exist."
    fi
}
