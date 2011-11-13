require '../../app'
request = require 'request'

good_url = 'http://admin:thomas@localhost:3000'

describe 'Applications#register', ->
  it 'success is true', -> 
    request.put 
      uri: [good_url, 'applications', 'foo'].join('/')
      json: true
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()
