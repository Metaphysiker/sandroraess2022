#!/bin/bash
rails assets:clobber
RAILS_ENV=production rails assets:clobber
RAILS_ENV=production rails assets:precompile
git add .
git commit -m "precompile"
git push origin main

ssh deploy@159.223.30.119 << EOF
  cd sandroraess2022
  git stash
  git pull origin main
  bundle config set --local deployment 'true'
  bundle config set --local without 'development test'
  bundle install
  yarn install
  RAILS_ENV=production rails db:migrate
EOF

ssh root@159.223.30.119 << EOF
  cd /home/sandro/sandroraess2022/
  sudo service nginx restart
EOF

rails assets:clobber
