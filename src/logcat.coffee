child_process  = require 'child_process'
colors         = require 'colors'

argv = require('optimist')

    .usage( 

        """
        Filter output from adb logcat.

        Usage: noyd --logcat -w YourLogTag
        """
    )
    .demand('l')
    .boolean('l')
    .alias('l','logcat')
    .describe('l', 'Start the android log stream.')
    .alias('w', 'white')
    .describe('w', 'Match to whiten.')
    .boolean('s')
    .alias('s','silent')
    .describe('s','Only show matches and exceptions')
    .argv

module.exports = class Logcat

    @processLine: (line) -> 
        return if line.length == 0
        if argv.white and line.match argv.white
            console.log line.white.bold
        else
            first2 = line.slice(0,2)
            switch first2
                when 'E/'
                    if line.match /Exception/
                        console.log line.bold.red
                    else if line.match /\tat\s/
                        console.log line.red
                    else
                        console.log line.grey unless argv.silent
                else 
                    console.log line.grey unless argv.silent

    @run: -> 
        child = null
        process.on 'SIGINT', -> child.kill()
        if argv.logcat 
            options = ['logcat']
            child = child_process.spawn 'adb', options
            child.stdout.on 'data', (data) =>
                buffer = new Buffer(data) 
                for line in buffer.toString().split '\n'
                    @processLine line
