
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
ECHO "regen for %REV%" | git commit-tree `git write-tree` -p `git rev-parse HEAD` -p %REV% | xargs git reset --hard
git push origin gh-pages

cd ..
