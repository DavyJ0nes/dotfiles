#!/usr/bin/env node
console.time('execution time')
var fs = require('fs')
var path = require('path')
var backup = require(path.join(__dirname, 'lib/backup.js'))

if (process.argv[2] === undefined) {
  if (fs.statSync(path.join(__dirname, 'config.json')).isFile()) {
    var config = require(path.join(__dirname, 'config.json'))
  }
}

var src = process.argv[2] || config.src
var dest = process.argv[3] || config.dest

backup(src, dest)
