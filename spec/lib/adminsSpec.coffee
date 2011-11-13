admins = require [__dirname, '../../lib/admins'].join('/')

describe 'admins', ->
  it '#register', ->
    admins.register 'admin', 'thomas', 'thomas', (err) ->
      expect(err).toBeNull()
      asyncSpecDone()
    asyncSpecWait()
  describe '#authenticate', ->
    it 'should be valid', ->
      admins.authenticate 'admin', 'thomas', (err) ->
        expect(err).toBeNull()
        asyncSpecDone()
      asyncSpecWait()
    it 'should be invalid pasword', ->
      admins.authenticate 'admin', 'disel11', (err) ->
        expect(err.message).toEqual('Password Invalid')
        asyncSpecDone()
      asyncSpecWait()
    it 'should be invalid user', ->
      admins.authenticate 'noname', 'disel11', (err) ->
        expect(err.message).toEqual('Admin Invalid')
        asyncSpecDone()
      asyncSpecWait()
  