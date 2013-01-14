module.exports = class Logcat

    @run: -> @stdin()

    @stdin: ->

        process.stdin.resume()
        process.stdin.setEncoding 'utf8'
        process.stdin.on 'end', -> # console.log "END"


        process.stdin.on 'data', (chunk) ->

            console.log 'STDIN: ' + chunk
