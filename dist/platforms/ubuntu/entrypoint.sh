#!/usr/bin/env bash

#
# Create directory for license activation
#

ACTIVATE_LICENSE_PATH="$GITHUB_WORKSPACE/_activate-license~"
mkdir -p "$ACTIVATE_LICENSE_PATH"

pwd
ls -lashi
pushd /opt/unity/Editor/Data
pwd
ls -lashi
mv bee_backend bee_backend_real
cp /steps/bee_backend bee_backend
chmod +x bee_backend
ls -lashi
popd
pwd
ls -lashi

#
# Run steps
#
source /steps/set_gitcredential.sh
source /steps/activate.sh
source /steps/build.sh
source /steps/return_license.sh

#
# Remove license activation directory
#

rm -r "$ACTIVATE_LICENSE_PATH"

#
# Instructions for debugging
#

if [[ $BUILD_EXIT_CODE -gt 0 ]]; then
echo ""
echo "###########################"
echo "#         Failure         #"
echo "###########################"
echo ""
echo "Please note that the exit code is not very descriptive."
echo "Most likely it will not help you solve the issue."
echo ""
echo "To find the reason for failure: please search for errors in the log above."
echo ""
fi;

#
# Exit with code from the build step.
#

exit $BUILD_EXIT_CODE
