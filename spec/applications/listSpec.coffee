require '../../app'
request = require 'request'

good_url = 'http://admin:test@localhost:3000'

describe 'Applications#list', ->
  it 'should return all owners apps', -> 
    request.get 
      uri: [good_url, 'applications'].join('/')
      json: true
      (err, resp, body) -> 
        expect(body.applications).toBeDefined()
        asyncSpecDone()
    asyncSpecWait()
