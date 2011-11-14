require '../../app'
request = require 'request'

#good_url = 'http://admin:thomas@localhost:3000'
good_url = 'http://jackadmin:thomas63@authur.wilbur.io'


describe 'Applications#register', ->
  it 'success is true', -> 
    request.put 
      uri: [good_url, 'applications', 'app1'].join('/')
      json: true
      (err, resp, body) -> 
        expect(body.success).toEqual(true)
        asyncSpecDone()
    asyncSpecWait()
