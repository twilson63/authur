express = require 'express'
applications = require './lib/applications'
users = require './lib/users'
admins = require './lib/admins'


auth = (user, password, cb) -> admins.authenticate user, password, cb 
 
app = express.createServer()
app.use express.bodyParser()

## Authur 1.0
#
#
# # Applications
#
# Register Application
app.put '/applications/:name', express.basicAuth(auth), (req, resp) ->
  applications.register req.params.name, 'Admin', (err) ->
    resp.json { success: (if err? then false else true) }
# Get all apps by owner
app.get '/applications', express.basicAuth(auth), (req, resp) ->
  applications.all req.remoteUser.username, (err, applications) -> 
    resp.json { applications }

# # Users
#
# Register User
app.put '/users/:username', express.basicAuth(auth), (req, resp) ->
  users.register req.params.username, req.body.password, req.body.confirm, (err) ->
    resp.json { success: (if err? then false else true)}

# Attach App
app.post '/users/:username/apps/:app', express.basicAuth(auth), (req, resp) ->
  users.attachApp req.params.username, req.params.app, (err, result) ->
    resp.json { success: (if err? then false else true) }

# Auth
app.post '/auth/:app', express.basicAuth(auth), (req, resp) ->
  users.authenticate req.body.username, req.body.password, (err, apps) -> 
    unless err?
      resp.json { success: if req.params.app in apps then true else false }
    else
      resp.json { success: false }
    

app.listen 3000, -> console.log 'Listening on port 3000'