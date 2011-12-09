express = require 'express'

applications = require './lib/applications'
users = require './lib/users'
admins = require './lib/admins'


auth = (user, password, cb) -> admins.authenticate user, password, cb 
 
app = express.createServer()

app.configure ->
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static './public'


## Authur 1.0
#
# # WebSite
app.get '/', (req, resp) ->
  if req.is('application/json')
    resp.json welcome: 'Authur 0.1.0'
  else
    resp.render "index"

app.get '/register', (req, resp) ->
  resp.render "register"

app.post '/admins', (req, resp) ->
  # TODO: Validate Document
  if req.body? and req.body.username? and req.body.password? and req.body.confirm?
    admins.register req.body, (err, admin) ->
      if req.is('application/json')
        resp.json success: true unless err?
      else
        resp.render "success" unless err?
  else
    errors = []
    errors.push "Admin Object is Required!" if !req.body?
    errors.push "Attribute: username is required!" if !req.body.username?
    errors.push "Attribute: password is required!" if !req.body.password?
    errors.push "Attribute: confirm is required!" if !req.body.confirm?
    resp.writeHead 400, 'Content-Type': 'application/json'
    resp.end JSON.stringify(errors: errors)

#
# # Applications
#
# Register Application
app.put '/applications/:name', express.basicAuth(auth), (req, resp) ->
  applications.register req.params.name, req.remoteUser.username, (err) ->
  resp.json { success: (if err? then false else true) }

  
# Get all apps by owner
app.get '/applications', express.basicAuth(auth), (req, resp) ->
  applications.all req.remoteUser.username, (err, applications) -> 
    resp.json { applications }

# # Users
#
# Register User
app.put '/users/:username', express.basicAuth(auth), (req, resp) ->
  if req.body?.password? and req.body?.confirm?  
    users.register req.params.username, req.body.password, req.body.confirm, (err) ->
      resp.json { success: (if err? then false else true)}
  else
    errors = []
    errors.push "User Object is Required!" if !req.body?
    errors.push "Attribute: username is required!" if !req.body.username?
    errors.push "Attribute: password is required!" if !req.body.password?
    errors.push "Attribute: confirm is required!" if !req.body.confirm?
    resp.writeHead 400, 'Content-Type': 'application/json'
    resp.end JSON.stringify(errors)    


# Attach App
app.post '/users/:username/apps/:app', express.basicAuth(auth), (req, resp) ->
  users.attachApp req.params.username, req.params.app, (err, result) ->
    resp.json { success: (if err? then false else true) }

# Auth
app.post '/auth/:app', express.basicAuth(auth), (req, resp) ->
  if req.body? and req.body.username? and req.body.password?
    users.authenticate req.body.username, req.body.password, (err, apps) -> 
      unless err?
        resp.json { success: if req.params.app in apps then true else false }
      else
        resp.json { success: false }
  else
    errors = []
    errors.push "User Object is Required!" if !req.body?
    errors.push "Attribute: username is required!" if !req.body.username?
    errors.push "Attribute: password is required!" if !req.body.password?
    resp.writeHead 400, 'Content-Type': 'application/json'
    resp.end JSON.stringify(errors)            

app.listen process.env.VMC_APP_PORT or 3000, -> console.log 'Listening...'