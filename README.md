# tureloRails

Whenever I want to learn a new programming language I re-write my API driven RSS Reader, it covers off a few areas that I feel are core to any development language

- Web Server & Sockets
- Database Interations (basic to medium complexity)
- Authentication
- Scheduled or Trigger Tasks
- Deployment Pipelines

This exaple is written in Ruby with the Ruby on Rails webframework, this example contains the backend service and webapp in a single overall deployable app.

I have also included a docker compose file that includes all required services for this project to operates

- Elasticsearch
- Redis
- PostgreSQL


## Steps to Install

For this projec to work you will need a local (or accessable) PostgreSQL database installed, create your database and update the settings in the app.yaml configuration

Then execute the script in the test data directory, db.sql to import some base 'fact' data 

I use glide for dependcy management so ensure it's installed'

git clone https://github.com/kebabmane/quizzleGo.git

cd quizzleGo

brew install glide

glide install

go run server.go'


Cheers
Rhys / @kebabman