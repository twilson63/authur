users = require [__dirname, '../../lib/users'].join('/')

describe 'users', ->
  it '#register', ->
    users.register 'jackhq', 'disel10', 'disel10', (err) ->
      expect(err).toBeNull()
      asyncSpecDone()
    asyncSpecWait()
  describe '#authenticate', ->
    it 'should be valid', ->
      users.authenticate 'jackhq', 'disel10', (err) ->
        expect(err).toBeNull()
        asyncSpecDone()
      asyncSpecWait()
    it 'should be invalid pasword', ->
      users.authenticate 'jackhq', 'disel11', (err) ->
        expect(err.message).toEqual('Password Invalid')
        asyncSpecDone()
      asyncSpecWait()
    it 'should be invalid user', ->
      users.authenticate 'noname', 'disel11', (err) ->
        expect(err.message).toEqual('User Invalid')
        asyncSpecDone()
      asyncSpecWait()