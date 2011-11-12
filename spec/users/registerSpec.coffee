require '../../app'
request = require 'request'

good_url = 'http://admin:test@localhost:3000'

describe 'Users#register', ->
  it 'success is true', -> 
    request.put 
      uri: [good_url, 'users', 'user'].join('/')
      json: { password: 'disel10', confirm: 'disel10' }
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()
