express = require 'express'
applications = require './lib/applications'

app = express.createServer()

app.use express.bodyParser()

app.put '/applications/:name', (req, resp) ->
  applications.register req.params.name, 'Admin', (err) ->
    resp.json { success: (if err? then false else true) }

app.get '/applications', (req, resp) ->
  applications.all 'Admin', (err, applications) -> 
    resp.json { applications }

app.listen 3000, -> console.log 'Listening on port 3000'