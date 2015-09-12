[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/rgbycch/rgbycch-rest/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/rgbycch/rgbycch-rest/master.svg?style=flat)](https://travis-ci.org/rgbycch/rgbycch-rest)

# rgbycch-rest
RESTful API for rgbycch system. Rails based API service.

# Initial Development Setup for Mac OSX
1. Install rvm at https://rvm.io
2. Install the `2.2` version of ruby with ```$ rvm install 2.2```
3. Ensure you are using the `2.2` version of ruby with a ```rvm use 2.2``` command.
4. Install the following bundles on your system
```
$ gem install bundler
$ gem install foreman
$ gem install rails -v 4.0
```
5. Check out the codebase.
6. Install [pow](http://pow.cx) with ```curl get.pow.cx | sh```
7. Create the symlink for pow:
```
cd ~/.pow
ln -s ~/workspace/rgbycch-rest
```
8. Install the bundle by executing a ```bundle install``` command at the base of the project.
9. Navigate to the [base of the server](http://rgbycch-rest.dev:3000) and you should see the rails sample start page.

# Running Tests

# Contributing
Contributions to the development of the RESTful API application are always welcome. Some guidelines:
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

There's a simple well-intentioned [Code of Conduct](http://contributor-covenant.org/version/1/2/0/code_of_conduct.txt) for any community that might spring up around the development of the RESTful API too.