[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/rgbycch/rgbycch-rest/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/rgbycch/rgbycch-rest/master.svg?style=flat)](https://travis-ci.org/rgbycch/rgbycch-rest)

# rgbycch-rest
RESTful API for rgbycch system

SETUP

1 clone the project and open a terminal window at the project folder

2 run 'mvn clean install -DskipTests' to build the api

3 run 'mvn jetty:run -DskipTests' to start the test api at http://localhost:8080

NOTE: There are a number of ways to look at look at the API documentation. One can look http://localhost:8080/api-docs for api json data from swagger. One can also clone https://github.com/swagger-api/swagger-ui and point an apache server at {swagger-ui-clone}/dist to use the swagger-ui tool. 
