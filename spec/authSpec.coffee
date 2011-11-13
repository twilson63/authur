require '../app'
request = require 'request'

good_url = 'http://admin:thomas@localhost:3000'

describe 'app#auth', ->
  it 'success is true', -> 
    request.post
      uri: [good_url, 'auth', 'app1'].join('/')
      json: { username: 'jackhq', password: 'disel10' }
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()
