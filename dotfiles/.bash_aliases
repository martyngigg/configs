# -*-shell-script-*-
################################################################################
# .bash_aliases: sourced from .bashrc to provide command aliases.
#                color_dirs is set in .bashrc
# Author: Martyn Gigg
################################################################################

################################################################################
# misc
################################################################################

# find the number of cores (includes hyperthreaded ones)
ncores=$(grep -c ^processor /proc/cpuinfo)

if [ "$color_dir" = yes ]; then
  alias ls="ls --human-readable --ignore-backups --color=auto"
else
  alias ls="ls --human-readable --ignore-backups"
fi
alias ll="ls -l"
alias la="ls -A"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias du="du -h"
alias df="df -h"
alias maxsize="du -m --max-depth=1 | sort -k1nr"
alias nmacs="emacs -nw"
alias top="htop"

# clue's in the name
function mkdirandcd { mkdir -p "$1"; cd "$1"; }
# remove all files ending in "~", below the current directory
function clr_emacs { find . -type f \( -name '*~' \) -print0 | xargs -0 -I\{\} rm \{\} ;}

# get http response code
http_code() {
    curl -sL -w "%{http_code}\n" $1 -o /dev/null
}

################################################################################
# cmake
################################################################################
# always output on failure & run on maximum number of cores
alias ctest="ctest --output-on-failure -j$ncores"

################################################################################
# git (move to .gitconfig)
################################################################################
# short aliases
alias gs="git status"
alias gf="git fetch"
alias gl="git log"
alias glo="git log --oneline"
alias glm="git log --merges --oneline"

function gitmergelog {
    if [ $# -eq 0 ]; then
      "echo Supply a merge commit SHA1"
      return 1
    fi
    format="--pretty=oneline --abbrev-commit"
    order=""
    pos_arg=0
    for i in "$@"; do
        case $i in
            "-b")
	    format="--pretty=format:%h"
	    continue
            ;;
            "-r")
            order="--reverse"
            continue
        esac
        case $pos_arg in
            0) merge_commit=$i;;
        esac
        pos_arg=$((pos_arg+1))
    done
    git log $(git merge-base ${merge_commit}^1 ${merge_commit}^2)..${merge_commit}^2 $format $order
}

################################################################################
# valgrind
################################################################################

# callgrind shortcut
alias callgrind="valgrind --tool=callgrind --instr-atstart=no --collect-atstart=no --dump-instr=yes --simulate-cache=yes --collect-jumps=yes"

# memcheck with deep
alias memcheck-deep="valgrind --tool=memcheck --leak-check=full --show-reachable=yes --num-callers=20 --track-fds=yes --track-origins=yes --freelist-vol=500000000 -v -v"

# Run memcheck like the buildservers
# First argument should be the directory of the Mantid suppressions files
# The remaining arguments are passed to valgrind
memcheck-ci() {
    if [ $# -lt 2 ]; then
        echo "Usage: memcheck suppressions_dir program [arguments...]"
    else
        OPTS="--leak-check=full --show-reachable=no --undef-value-errors=yes --track-origins=no --child-silent-after-fork=no --trace-children=no --demangle=no --num-callers=20"
        SUPPR="--suppressions=$1/KernelTest.supp --suppressions=$1/GeometryTest.supp --suppressions=$1/APITest.supp --suppressions=$1/DataObjectsTest.supp"
        shift 1 # Eat the directory argument

        valgrind --tool=memcheck  ${OPTS} ${SUPPR} $@
    fi
}

# Run valgrind with helgrind thread checker, warning about custom gcc
helgrind () {
    echo "WARNING: Have you set the path to the gcc build that disables the futex option?"
    if [ $# -lt 2 ]; then
        echo "Usage: helgrind logfile program [arguments...]"
    else
        logfile=$1
	shift 1 # Eat the logfile argument
        valgrind --tool=helgrind --num-callers=20 --log-file=$logfile $@
    fi
}


################################################################################
# mantid
################################################################################
# Set the given directory to find Mantid python
set_mtd_path () {
    export MANTIDPATH=$1
    export PYTHONPATH=$MANTIDPATH:$PYTHONPATH
}

# Find a file on the archive
find_run() {
    curl -L http://data.isis.rl.ac.uk/where.py/unixdir?name=$1
    ## result doesn't come back with new line
    echo
}
