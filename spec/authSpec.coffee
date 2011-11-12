require '../app'
request = require 'request'

good_url = 'http://admin:test@localhost:3000'

describe 'app#auth', ->
  it 'success is true', -> 
    request.post
      uri: [good_url, 'auth', 'app1'].join('/')
      json: { username: 'jackhq', password: 'foo' }
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()