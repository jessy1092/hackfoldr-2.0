
git --version

set upstream=lee
set REPO=git@github.com:jessy1092/hackfoldr-2.0

git fetch %upstream%

rm -rf _public

rem XXX: use --reference when not in shallow clone
rem git clone $REPO --reference . -b gh-pages _public
git clone %REPO% -b gh-pages _public

set REV=`git describe --always`

call ./node_modules/.bin/gulp --require LiveScript build

cd _public

git add -A .
git commit -m 'deploy'
git push origin gh-pages

cd ..
