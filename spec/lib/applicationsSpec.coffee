applications = require [__dirname, '../../lib/applications'].join('/')

describe 'applications', ->
  it '#list', ->
    applications.all 'Admin', (err, applications) ->
      expect(applications).toBeDefined()
      asyncSpecDone()
    asyncSpecWait()