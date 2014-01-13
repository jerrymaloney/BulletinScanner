#!/bin/sh
SCRIPTPWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo puppet apply $SCRIPTPWD/../puppet/manifests/default.pp --modulepath $SCRIPTPWD/../puppet/modules
$SCRIPTPWD/test-tesseract.sh