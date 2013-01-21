child_process  = require 'child_process'
colors         = require 'colors'
ant            = require './ant'
children       = require './children'


module.exports = class Logcat

    @writeLine: (line) -> 
        ant.writeLine 'logcat '.blue + ': '.bold.white, line


    @processLine: (argv, line) -> 
        return if line.length == 0

        if argv.tag and line.match argv.tag
            @writeLine line.white.bold

        else
            first2 = line.slice(0,2)

            switch first2

                #
                # match exceptions
                # 

                when 'E/'

                    if line.match /Exception/
                        @writeLine line.bold.red

                    else if line.match /\tat\s/
                        @writeLine line.red

                    else
                        @writeLine line.grey unless argv.silent

                else 
                    @writeLine line.grey unless argv.silent

    @run: (argv) -> 

        child = null
        process.on 'SIGINT', -> child.kill()
        options = ['logcat']
        child = child_process.spawn 'adb', options
        children.add child
        child.stdout.on 'data', (data) =>
            buffer = new Buffer(data) 
            for line in buffer.toString().split '\n'

                @processLine argv, line
