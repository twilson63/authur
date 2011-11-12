# connection info
request = require 'request'
memcache = require 'memcache'

db = new memcache.Client()
views = require './db'

# Users
module.exports = 
  register: (username, password, confirm, cb) ->
    return cb(new Error('Password and Confirm not equal.')) unless password == confirm
    db.connect()
    db.set "user-#{username}", JSON.stringify( { username, password } ), (err, result) ->
      db.close()
      unless err? then cb(null) else cb(new Error('Unable to create user'))
  authenticate: (username, password, cb) ->
    db.connect()
    db.get "user-#{username}", (err, user) ->
      db.close()
      unless JSON.parse(user)?
        return cb(new Error('User Invalid'))
      else
        return if password == JSON.parse(user).password then cb(null)  else cb(new Error('Password Invalid'))
               
  appsForUser: (username, cb) ->
    request.get
      uri: [views, 'appsByUser']
      json: { key: username }
      (err, resp, body) ->
        apps = (app.value for app in body.rows)
        cb(null, apps)
