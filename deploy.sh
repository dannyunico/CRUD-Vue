#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist


git add -A
git commit -m 'responsive'

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push -f https://github.com/dannyunico/CRUD-Vue.git master:gh-pages

cd -