http = require("http")
http = require("http")
express = require("express")

exports.TESTING_PORT = 12345
exports.request = (method, path, options, fn) ->
  if typeof(options) == 'function'
    fn = options
    options = undefined
  options = options || { headers: [] }
  req = http.request({
      method: method
    , port: exports.TESTING_PORT
    , host: 'localhost'
    , path: path
    , headers: options.headers
  })
  fullResponse = ''
  req.on 'socket', (response, socket, head) ->
    response.on 'data', (data) ->
      fullResponse += data.toString()
  req.on 'response', (res) ->
    buf = ''
    res.setEncoding('utf8');
    res.on 'data', (chunk) ->
      buf += chunk
    res.on 'end', ->
      res.body = buf
      res.fullResponse = fullResponse
      fn(res)
  req.end()

class Server
  start: ->
    app = express()
    app.get('*', @handleRequest)
    app.post('*', @handleRequest)
    app.delete('*', @handleRequest)
    app.put('*', @handleRequest)
    @server = app.listen(exports.TESTING_PORT)
  stop: ->
    @server.close()
  handleRequest: (req, res) ->
    res.send({})

exports.Server = Server
