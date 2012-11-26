should = require('chai').should()
utils = require('./utils')
request = utils.request
require('../index')

describe 'broware', ->
  server = undefined
  beforeEach ->
    server = new utils.Server
    server.start()
  afterEach ->
    server.stop()

  it 'GET => 200 => Here you go Bro', (done) ->
    request 'get', '/', (res) ->
      res.statusCode.should.equal 200
      firstLine = res.fullResponse.split('\r\n')[0];
      firstLine.should.equal 'HTTP/1.1 200 Here you go Bro'
      done()