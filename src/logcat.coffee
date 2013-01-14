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
    .argv



module.exports = class Logcat

    @processLine: (line) -> 
        return if line.length == 0
        if argv.white and line.match argv.white
            console.log line.white.bold
        else
            first2 = line.slice(0,2)
            switch first2
                when 'W/' then console.log line.bold.red
                else console.log line.grey

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
