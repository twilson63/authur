# connection info
request = require 'request'
memcache = require 'memcache'

db = new memcache.Client()
views = require './db'

# Users
module.exports = 
  register: (username, password, confirm, cb) ->
    return cb(new Error('Password and Confirm not equal.')) unless password == confirm
    @_save { username, password }, (err, result) -> 
      unless err? then cb(null) else cb(new Error('Unable to create user'))
  
  authenticate: (username, password, cb) ->
    @_get username, (err, user) ->
      if err?
        cb(new Error('User Invalid'))
      else 
        if password == user.password then cb(null, user.apps ? [])  else cb(new Error('Password Invalid'))

  attachApp: (username, app, cb) ->
    @_get username, (err, user) => 
      unless err?
        user.apps = [] unless user.apps?
        user.apps.push app
        @_save user, cb
              
  appsForUser: (username, cb) ->
    request.get
      uri: [views, 'appsByUser']
      json: { key: username }
      (err, resp, body) ->
        apps = (app.value for app in body.rows)
        cb(null, apps)
  
  #bolierplate get
  _get: (username, cb) ->
    db.connect()
    db.get "user-#{username}", (err, userDoc) ->  
      db.close()
      if err?
        cb err, null
      else if userDoc?
        cb null, JSON.parse(userDoc) 
      else
        cb new Error('User Not Found'), null

  _save: (user, cb) ->
    db.connect()
    db.set "user-#{user.username}", JSON.stringify(user), (err, result) ->
      db.close()
      if err? then cb(err, null) else cb(null, result) 