require '../app'
request = require 'request'

describe 'GET /index', ->
  it '#get', (done) ->
    request.get 
      uri: 'http://localhost:3000/'
      json: true
      (err, resp, body) -> 
        resp.statusCode.should.eql 200
        body.welcome.should.eql 'Authur 0.1.0'
        done()
describe 'POST /admins', ->
  it 'creates admin account', (done) ->
    request.post
      uri: 'http://localhost:3000/admins'
      json: username: 'admin', password: 'admin', confirm: 'admin'
      (err, resp, body) ->
        resp.statusCode.should.eql 200
        body.success.should.be.ok
        done()
  it 'returns 400 if no body', (done) ->
    request.post
      uri: 'http://localhost:3000/admins'
      json: {}
      (err, resp, body) ->
        resp.statusCode.should.eql 400
        body.errors.length.should.eql 3
        done()
describe 'PUT /applications/:name', ->
  it 'creates application for owner', (done) ->
    request.put
      uri: 'http://admin:admin@localhost:3000/applications/foobar'
      json: {}
      (err, resp, body) ->
        resp.statusCode.should.eql 200
        body.success.should.be.ok
        done()
# describe 'POST /users', ->
#   it '#post', (done) ->
#     request.post
#       uri: 'http://admin:admin@localhost:3000/users'
#       json: username: 'twilson63', password: 'stars', confirm: 'stars'
#       (err, resp, body) ->
#         body.success.should.eql true
#         done()
# describe 'POST /users/:username/applications', ->
#   it '#post', (done) ->
#     request.post
#       uri: 'http://admin:admin@localhost:3000/users/twilson63/applications'
#       json: name: 'foobar'
#       (err, resp, body) ->
#         body.success.should.eql true
#         done()
# describe 'POST /auth', ->
#   it '#post', (done) ->
#     request.post
#       uri: 'http://admin:admin@localhost:3000/auth'
#       json: username: 'twilson63', password: 'stars', app: 'foobar'
#       (err, resp, body) ->
#         body.success.should.eql true
#         done()