require '../../app'
request = require 'request'

good_url = 'http://admin:thomas@localhost:3000'

describe 'Users#attachApp', ->
  it 'success is true', -> 
    request.post 
      uri: [good_url, 'users', 'user', 'apps', 'app1'].join('/')
      json: true
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()

  # it 'success is false', -> 
  #   request.post 
  #     uri: [good_url, 'users', 'nouser', 'apps', 'app1'].join('/')
  #     json: true
  #     (err, resp, body) -> 
  #       expect(body.success).toEqual(false)
  #       asyncSpecDone()
  #   asyncSpecWait()
