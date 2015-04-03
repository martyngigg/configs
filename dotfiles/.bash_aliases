## Aliases to make life easier :)
alias ls='ls --human-readable --ignore-backups --color=auto'
alias ll='ls -l -h'
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias du="du -h"
alias maxsize="du -m --max-depth=1 | sort -k1nr"
alias df="df -h"

## emacs text-mode
alias nmacs="emacs -nw"

# clues in the name
function mkdirandcd { mkdir -p "$1"; cd "$1"; }

# Remove all files ending in "~", below the current directory
function cleanemacsfiles { find . -type f \( -name '*~' \) -print0 | xargs -0 -I\{\} rm \{\} ;}
alias swp="cleanemacsfiles"

# Make ctest to include --output-on-failure
alias ctest="ctest --output-on-failure -j8"

# Git
alias gs="git status"
alias gf="git fetch"
alias gl="git log"
alias glo="git log --oneline"
alias glm="git log --merges --oneline"
alias gp="git push"
alias gpc="git push checkmantid"

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


# Run memcheck with standard options
alias memgrind="valgrind --tool=memcheck --leak-check=full --show-reachable=yes --num-callers=20 --track-fds=yes --track-origins=yes --freelist-vol=500000000 -v -v"

# Run callgrind with usuable options
alias callgrind="valgrind --tool=callgrind --instr-atstart=no --collect-atstart=no --dump-instr=yes --simulate-cache=yes --collect-jumps=yes"

# Run valgrind like the buildservers
# First argument should be the directory of the Mantid suppressions files
# The remaining arguments are passed to valgrind
memcheck() {
    if [ $# -lt 2 ]; then
        echo "Usage: memcheck suppressions_dir program [arguments...]"
    else
        OPTS="--leak-check=full --show-reachable=no --undef-value-errors=yes --track-origins=no --child-silent-after-fork=no --trace-children=no --demangle=no"
        SUPPR="--suppressions=$1/KernelTest.supp --suppressions=$1/GeometryTest.supp --suppressions=$1/APITest.supp --suppressions=$1/DataObjectsTest.supp"
        shift 1 # Eat the directory argument

        valgrind --tool=memcheck  ${OPTS} ${SUPPR} $@
    fi
}

# Rebuild debian package
# Requires following packages: build-essential fakeroot devscripts
alias rebuilddeb="debuild -us -uc -i -I"

# Run valgrind with helgrind checker, warning about custom gcc
helgrind () {
    echo "!!WARNING: Have you set the path to the custom gcc build!!"
    if [ $# -lt 2 ]; then
        echo "Usage: helgrind logfile program [arguments...]"
    else
        logfile=$1
	shift 1 # Eat the logfile argument
        valgrind --tool=helgrind --num-callers=20 --log-file=$logfile $@
    fi
}

# Fix up eclipse project to build with given number of cores
patch_cproj () {
    sed -i -e "s@<buildArguments/>@<buildArguments>-j$2</buildArguments>@g" "$1"
}

# Set the given directory to find Mantid python
set_mtd_path () {
    export MANTIDPATH=$1
    export PYTHONPATH=$MANTIDPATH:$PYTHONPATH
}

# Set the current compiler to the no futex version
set_helgrind_compiler() {
  export PATH=export PATH=/opt/compilers/gcc-4.6.3/bin:$PATH
  export LD_LIBRARY_PATH=/opt/compilers/gcc-4.6.3/lib64$LD_LIBRARY_PATH
  export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH
}


# Find a file on the archive
find_run() {
    curl -L http://data.isis.rl.ac.uk/where.py/unixdir?name=$1
    ## result doesn't come back with new line
    echo
}

# Get http response code
http_code() {
    curl -sL -w "%{http_code}\n" $1 -o /dev/null
}
