memcache = require 'memcache'
request = require 'request'

server = process.env.DBSERVER || "localhost"
views =  "http://#{server}:5984/default/_design/applications/_view"
# DB
db = new memcache.Client()

# # Applications 
module.exports =
  # register application
  register: (name, owner, cb) ->
    db.connect()
    db.set "application-#{name}", JSON.stringify({ name, owner }), (err, result) ->
      db.close()
      unless err? then cb(null) else cb(new Error('Unable to save app'))
  # all apps by owner
  all: (owner, cb) ->
    db.connect()
    request.get 
      uri: [views, 'all'].join('/')
      json: { key: owner }
      (err, resp, body) ->
        apps = (app.value for app in body.rows)
        db.close()
        cb(null, apps)