# connection info
request = require 'request'
memcache = require 'memcache'

db = new memcache.Client()
views = require './db'

# # Auth 
module.exports = (username, password, cb) ->
  # authenticate user
  db.get "user-#{username}", (err, user) ->
    if err?
      return cb(err)
    else
      console.log user   