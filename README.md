[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/rgbycch/rgbycch-rest/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/rgbycch/rgbycch-rest/master.svg?style=flat)](https://travis-ci.org/rgbycch/rgbycch-rest)
# rgbycch-rest
RESTful API for rgbycch system. Rails based API service.
# Initial Development Setup for Mac OSX
1. Install rvm at https://rvm.io
2. Install the `2.3.1` version of ruby with ```$ rvm install 2.3.1```
3. Ensure you are using the `2.3.1` version of ruby with a ```rvm use 2.3.1``` command.
4. Install the following bundles on your system
  ```
  $ gem install bundler
  $ gem install foreman
  $ gem install rails -v 5.0.2
  ```
5. Check out the codebase.
6. Install [pow](http://pow.cx) with ```curl get.pow.cx | sh```
7. Create the symlink for pow:
  ```
  cd ~/.pow
  ln -s ~/workspace/rgbycch-rest
  (pow can be restarted by running touch ~/.pow/restart.txt)
  ```
8. Install the bundle by executing a ```bundle install``` command at the base of the project.
9. Generate your configuration using ```bundle exec figaro install```
10. Get the database up and running:
  ```
  rm db/*.sqlite3
  bundle exec rake db:setup
  bundle exec rake db:test:prepare
  ```
11. Start the server
  ```
  bundle exec rails server
  ```
12. Navigate to the [base of the server](http://rgbycch-rest.dev) and you should see the rails sample start page.
13. Generate a user by executing the following code from the base of the project:
  ```
  bundle exec rails console
  User.create({email: "tom@rgbycch.com",
                            password: "12345678",
                            password_confirmation: "12345678"})
  ```
14. Ensure that this user has been successfully created by:
```
curl -H 'Accept: application/vnd.rgbycch.v1' http://api.rgbycch-rest.dev/users/1.json
```
# Running Tests
```bundle exec rspec spec```
## simplecov
By default, coverage is executed every time you run the unit tests. See the `coverage` directory for details after running your tests.
# Creating and Recreating the Database
If you ever want a completely fresh install of the db, just clobber it with:
```
rm db/*.sqlite3
bundle exec rake db:setup
bundle exec rake db:test:prepare
```
# CRUD with curl
Before you start making any API calls, you'll need an ```authToken``` back for one of the users in the system.
A user's current session ```authToken``` can easily be returned at any time with:
```
curl -H 'Accept: application/json,application/vnd.rgbycch.v1' -X POST 'http://api.rgbycch-rest.dev/sessions.json' -d 'session[email]=tom@rgbycch.com&session[password]=12345678'
```
Creating a new player should be as easy as:
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X POST http://api.rgbycch-rest.dev/players.json -d '{"player": {"first_name": "First Name", "last_name": "Last Name", "nick_name": "Nick Name", "dob": "2015-09-17T10:24:05.000Z", "email": "email@gmail.com", "phone_number": "123456789"}}'
```
Finding a player by id:
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X GET http://api.rgbycch-rest.dev/players/1.json
```
Finding a player by ids:
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X GET http://api.rgbycch-rest.dev/players?player_ids=1,2
```
Finding a player by keyword:
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X GET http://api.rgbycch-rest.dev/players?keyword=Tom
```
Updating an existing player:
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' --request PATCH http://api.rgbycch-rest.dev/players/1.json -d '{"player": {"first_name": "First Name"}}'
```
Deleting a player:
```
curl -v -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' --request DELETE http://api.rgbycch-rest.dev/players/1.json
```
Adding a player to an existing team
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X PUT http://api.rgbycch-rest.dev/teams/[team_id_goes_here]/add_player.json -d '{"id": [player_id_goes_here]]}'
```
Removing a player from an existing team
```
curl -H 'Accept: application/vnd.rgbycch.v1' -H 'Authorization: [auth_token_goes_here]' -H 'Content-Type: application/json' -X PUT http://api.rgbycch-rest.dev/teams/[team_id_goes_here]/remove_player.json -d '{"id": [player_id_goes_here]]}'
```
# Documentation
## swagger
Run the following command to generate the swagger API documentation.
```
rake swagger:docs
```
Once the documentation has been generated, run the server with:
```
bundle exec rails server
```
To view the API docs, navigate to:
```
http://api.rgbycch-rest.dev/api/index.html
```
## sdoc
- `sdoc` documentation can be generated by invoking ```bundle exec sdoc app``` from the base of the project.

# brakeman
Run the following command to execute [brakeman](http://brakemanscanner.org/) on the codebase.
```
bundle exec brakeman
```
# traceroute
Run the following command to execute [traceroute](https://github.com/amatsuda/traceroute) on the codebase.
```
rake traceroute
```
# rubycritic
Run the following command to execute [rubycritic](https://github.com/whitesmith/rubycritic) on the codebase.
```
bundle exec rubycritic app
```
# Contributing
Contributions to the development of the RESTful API application are always welcome. Some guidelines:
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

There's a simple well-intentioned [Code of Conduct](http://contributor-covenant.org/version/1/2/0/code_of_conduct.txt) for any community that might spring up around the development of the RESTful API too.
