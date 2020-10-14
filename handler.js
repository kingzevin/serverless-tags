'use strict'
// environment variables specified by the user
process.env["MONGO_CONNECTION_STRING"] = `mongodb://172.17.0.1:27017/sharelatex`; // tags.config.env
// the user should specify the express listener
const expressListener = require('./app.js') // tags.express.file

const owServerlessExpress = require('./owServerlessExpress.js')

exports.main = function(params){ // tags.handler.function
  return owServerlessExpress(expressListener, params)
}