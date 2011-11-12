express = require 'express'
applications = require './lib/applications'
users = require './lib/users'
authenticate = require './lib/auth'

app = express.createServer()
app.use express.bodyParser()

# Applications

# Register Application
app.put '/applications/:name', (req, resp) ->
  applications.register req.params.name, 'Admin', (err) ->
    resp.json { success: (if err? then false else true) }

app.get '/applications', (req, resp) ->
  applications.all 'Admin', (err, applications) -> 
    resp.json { applications }

# Users

# Register User
app.put '/users/:username', (req, resp) ->
  users.register req.params.username, req.body.password, req.body.confirm, (err) ->
    resp.json { success: (if err? then false else true)}

# app.get '/users/:username/applications', (req, resp) ->
#   users.appsForUser req.params.username, (err, applications) ->
#     resp.json { applications }

# Auth

# Authenticate User for Applications
app.post '/auth/:app', (req, resp) ->
  authenticate req.params.app, req.body, (err) -> 
    resp.json { success: (if err? then false else true)}
    

app.listen 3000, -> console.log 'Listening on port 3000'