#!/bin/bash

yarn install
bundle check || bundle install
bundle exec rails db:migrate db:seed
shutup
bundle exec rails s -b "ssl://0.0.0.0:3000?key=$KEY_PATH&cert=$CERT_PATH"
