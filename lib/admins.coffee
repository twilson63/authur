# connection info
request = require 'request'
memcache = require 'memcache'

db = new memcache.Client()
views = require './db'

# Admins
module.exports = 
  register: (username, password, confirm, cb) ->
    return cb(new Error('Password and Confirm not equal.')) unless password == confirm
    @_save { username, password }, (err, result) -> 
      unless err? then cb(null) else cb(new Error('Unable to create user'))
  
  authenticate: (username, password, cb) ->
    @_get username, (err, admin) ->
      if err?
        cb(new Error('Admin Invalid'))
      else 
        if password == admin.password then cb(null, admin)  else cb(new Error('Password Invalid'))
  
  #bolierplate get
  _get: (username, cb) ->
    db.connect()
    db.get "admin-#{username}", (err, userDoc) ->  
      db.close()
      if err?
        cb err, null
      else if userDoc?
        cb null, JSON.parse(userDoc) 
      else
        cb new Error('Admin Not Found'), null

  _save: (admin, cb) ->
    db.connect()
    db.set "admin-#{admin.username}", JSON.stringify(admin), (err, result) ->
      db.close()
      if err? then cb(err, null) else cb(null, result) 
