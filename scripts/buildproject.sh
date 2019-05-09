#
# Build Split Script
#
# This script is used to split the build to allow individual project deployments
# The passed in manifest file contains the paths to the components to be deployed
#
# Once the individual project build is verified it can be build using:
#
# find src > project-manifest-NAME.txt
#

#mkdir tmp || true
#rm -rfv tmp/* || true
#cat 'project-manifest.txt' | xargs -t -d '\n' --verbose -a 'project-manifest.txt'  cp --parents -t 'tmp' || true
#rm -rfv src/* || true
#cp -R tmp/src/* src/
#rm -rfv tmp || true
#find src 

echo "Entered shell script"
#cd "$WORKSPACE"
#chmod -R 755 "$WORKSPACE"
echo "before mkdir"
mkdir tmp || true
echo "after mkdir"
rm -rf tmp/* || true
echo "after emptying tmp"
#cat $WORKSPACE/$1 | xargs -a $WORKSPACE/$1 cp --parents -t $WORKSPACE/tmp || true
sed -i 's/\r//g' 'project-manifest.txt' 
cat 'project-manifest.txt' | xargs -t -d '\n' --verbose -a 'project-manifest.txt'  cp --parents -t 'tmp' || true
echo "cat and xargs"
rm -rf src/* || true
echo "after rm -rf"
cp -r tmp/src/* src/
echo "copy tmp/src"
rm -rf tmp || true
#find src