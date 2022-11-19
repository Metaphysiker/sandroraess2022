#!/bin/bash
git add .
git commit -m "before merge"
git push origin dev
git checkout main
git merge dev
./deploy-to-digital-ocean-from-main-branch.sh
git checkout dev
git merge main
rails assets:clobber
git add .
git commit -m "after merge"
git push origin dev

echo "finished"
