child_process  = require 'child_process'
colors         = require 'colors'
keypress       = require 'keypress' 
keypress process.stdin


#
# task:  (prompt for running ant tasks) 
#

prompt = '  task : '.bold.white
input  = ''

module.exports = class Ant

    @writeLine: (context, line) -> 

        process.stdout.clearLine()
        process.stdout.cursorTo(0)
        console.log context + line
        process.stdout.write prompt + input

    @ant: (task) -> 

        options = [task]
        child = child_process.spawn 'ant', options
        child.stdout.on 'data', (data) =>
            buffer = new Buffer(data) 
            for line in buffer.toString().split '\n'
                #@writeLine 'build  '.green, ': '.bold.white + line
                @writeLine '   ant '.grey,': '.bold.white + line

        console.log ''
        return ''

    @input: (task) -> 

        unless task
            console.log ''
            return ''

        if task and task.length == 0
            console.log ''
            return ''

        return @ant task
    
    @run: (argv) -> 

        stdin  = process.openStdin()
        process.stdin.setRawMode(true)
        process.stdout.write prompt + input
        
        process.stdin.on 'keypress', (chunk, key) => 

            if key 

                if key.ctrl and key.name == 'c'
                    process.exit()

                else if key.ctrl and key.name == 'd'
                    process.exit()

                else if key.name == 'enter'
                    input = @input input
                    process.stdout.write prompt + input
                    return

                else if key.name == 'backspace'

                    #
                    # TODO: fix backspace
                    #

                    input = input.slice(0, input.length - 1)
                    process.stdout.clearLine()
                    process.stdout.cursorTo(0)
                    process.stdout.write prompt + input


                #else console.log key

            return unless chunk

            input += chunk.toString()
            process.stdout.clearLine()
            process.stdout.cursorTo(0)
            process.stdout.write prompt + input
