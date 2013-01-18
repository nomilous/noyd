fs     = require 'fs'
hound  = require 'hound'
colors = require 'colors'
java   = require 'java'

#
# If ./build.xml watch ./src dir and...
# 
# - display sintax errors on .java file change
# - pending2
# 
#

module.exports = class Build

    @writeLine: (line) -> 
        console.log 'build  - '.green + line

    @compile: (argv, file) -> 
        java.classpath.push __dirname
        java.callStaticMethod 'noyd.compile.Compiler', 'compileErrors', file, (err, result) => 
            if err
                @writeLine err.bold.red
                return
            else
                errors = 0
                for compileError in result
                    continue if compileError.match /does not exist/
                    continue if compileError.match /cannot find symbol/
                    continue if compileError.match /method does not override/
                    errors++
                    @writeLine compileError.split('\n')[0].bold.red
                if errors == 0
                    @writeLine 'syntax ok'.bold.green


    @watchDir: (argv, dir, callback) ->
        @writeLine 'watching ' + dir + ' directory for changes'
        watcher = hound.watch dir
        watcher.on 'change', callback


    @run: (argv) -> 

        fs.stat './build.xml', (err, stats) => 
            if err and err.code == 'ENOENT'
                @writeLine 'expected ./build.xml file'.bold.red
            return if err 


            @watchDir argv, './src', (file, stats) =>
                @writeLine ('detected changed file: ' + file).bold.white
                @compile argv, file

