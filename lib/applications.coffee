# connection info
request = require 'request'
memcache = require 'memcache'
crypto = require 'crypto'

db = new memcache.Client(11211, process.env.DBSERVER or "localhost")
views = require './db'

# # Applications 
module.exports =
  # register application
  register: (name, owner, cb) ->
    hash = crypto.createHash('sha1').update(name).digest('hex')
    db.connect()
    db.set "application-#{hash}", JSON.stringify({ name, owner }), (err, result) ->
      db.close()
      unless err? then cb(null) else cb(new Error('Unable to save app'))
  # all apps by owner
  all: (owner, cb) ->
    request.get 
      uri: [views, 'all'].join('/')
      json: { key: owner }
      (err, resp, body) ->
        apps = (app.value for app in body.rows)
        cb(null, apps)