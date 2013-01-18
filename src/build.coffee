fs     = require 'fs'
hound  = require 'hound'
colors = require 'colors'

#
# If ./build.xml watch ./src dir and...
# 
# - pending1
# - pending2
# 
#


module.exports = class Build

    @writeLine: (line) -> 
        console.log 'build  - '.green + line


    @watchDir: (argv, dir, callback) ->
        @writeLine 'watching %s directory for changes', dir 

        watcher = hound.watch dir
        watcher.on 'change', callback


    @run: (argv) -> 

        fs.stat './build.xml', (err, stats) => 
            if err and err.code == 'ENOENT'
                @writeLine 'expected ./build.xml file'.bold.red
            return if err 


            @watchDir argv, './src', (file, stats) =>
                @writeLine 'detected change file: ' + file
