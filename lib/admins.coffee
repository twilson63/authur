# connection info
request = require 'request'
memcache = require 'memcache'
bcrypt = require 'bcrypt'

db = new memcache.Client(11211, process.env.DBSERVER ? "localhost")
views = require './db'

# Admins
module.exports = 
  register: (username, password, confirm, cb) ->
    return cb(new Error('Password and Confirm not equal.')) unless password == confirm
    @_encrypt password, (err, salt, hash) =>
      @_save { username, salt, hash }, (err, result) -> 
        unless err? then cb(null) else cb(new Error('Unable to create user'))
  
  authenticate: (username, password, cb) ->
    @_get username, (err, admin) ->
      if err?
        cb(new Error('Admin Invalid'))
      else 
        bcrypt.compare password, admin.hash, (err, res) ->
          if res then cb(null, admin)  else cb(new Error('Password Invalid'))
  
  _encrypt: (password, cb) ->
      bcrypt.gen_salt 10, (err, salt) -> bcrypt.encrypt password, salt, (err, hash) -> cb(err, salt, hash)

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
