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

  testStatusCode = (statusCode, statusMessage, done) ->
    request 'get', '/' + statusCode, (res) ->
      res.statusCode.should.equal statusCode
      firstLine = res.fullResponse.split('\r\n')[0];
      firstLine.should.equal 'HTTP/1.1 ' + statusCode + ' ' + statusMessage
      done()

  it 'GET => 200 => Here you go Bro', (done) ->
    testStatusCode(200, 'Here you go Bro', done)