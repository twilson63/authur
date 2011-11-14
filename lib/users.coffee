# connection info
request = require 'request'
memcache = require 'memcache'
bcrypt = require 'bcrypt'

db = new memcache.Client(11211, process.env.DBSERVER ? "localhost")
views = require './db'

# Users
module.exports = 
  register: (username, password, confirm, cb) ->
    return cb(new Error('Password and Confirm not equal.')) unless password == confirm
    @_encrypt password, (err, salt, hash) =>
      @_save { username, salt, hash }, (err, result) -> 
        unless err? then cb(null) else cb(new Error('Unable to create user'))
  
  authenticate: (username, password, cb) ->
    @_get username, (err, user) ->
      if err?
        cb(new Error('User Invalid'))
      else 
        bcrypt.compare password, user.hash, (err, res) ->
          if res then cb(null, user.apps ? [])  else cb(new Error('Password Invalid'))

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

  _encrypt: (password, cb) ->
      bcrypt.gen_salt 10, (err, salt) -> bcrypt.encrypt password, salt, (err, hash) -> cb(err, salt, hash)
  
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