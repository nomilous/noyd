colors = require 'colors'

module.exports = class Logcat

    @run: -> @stdin()

    @stdin: ->

        process.stdin.resume()
        process.stdin.setEncoding 'utf8'
        process.stdin.on 'end', -> # console.log "END"

        process.stdin.on 'data', (chunk) ->

            # 
            # TODO? may need to handle non-linesynced chunks
            # 
            # buffer   = leftover + chunk
            # overlap  = buffer.slice(-1).match(/\n/) == null
            # lines    = buffer.split '\n'
            # if overlap
            #     leftover = lines.pop()
            #     console.log "\n\nLEFTOVER:" + leftover + "\n\n"
            # 
            # for line in lines

            for line in chunk.split '\n'
                first2 = line.slice(0,2)
                switch first2
                    when 'W/' then console.log line.bold.red
                    else console.log line.grey

