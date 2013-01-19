Lazy           = require 'lazy'
fs             = require 'fs'
child_process  = require 'child_process'
ant            = require './ant'

module.exports = class Action

    @writeLine: (line) ->
        ant.writeLine 'action '.yellow, ': '.bold.white + line

    @run: (argv, file) -> 

        lazy = Lazy fs.createReadStream file
        lazy.lines.forEach (chunk) =>

            line = chunk.toString()
            if line.match /^\/\/noyd:onchange:exec/

                exec = line.split('noyd:onchange:exec')[1]
                @writeLine 'running: ' + exec.bold.white
                child = child_process.spawn exec
                child.stdout.on 'data', (data) =>

                    buffer = new Buffer(data) 
                    for line in buffer.toString().split '\n'
                    
                        @writeLine line
