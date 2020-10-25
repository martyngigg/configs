# Set variables related to the running system.
# Generally used by sourcing this script

SYSTEM=$(uname -s)
ON_MACOS=false
ON_DEBIAN=false

if [ "$SYSTEM" == Darwin ]; then
  ON_MACOS=true
elif [ "$SYSTEM" == Linux ]; then
  if [ ! -z "$(which dpkg)" ]; then
    ON_DEBIAN=true
  else
    echo "Cannot find dpkg. Unknown Linux distro."
    exit 1
  fi
else
  echo "Unknown system found $SYSTEM"
  exit 1
fi
