fs     = require 'fs'
hound  = require 'hound'
colors = require 'colors'
java   = require 'java'
ant    = require './ant'
action = require './action'

#
# If ./build.xml watch ./src dir and...
# 
# - display sintax errors on .java file change
# - pending2
# 
#

module.exports = class Build

    @writeLine: (line) -> 
        ant.writeLine ' build '.green, ': '.bold.white + line

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
                    continue if compileError.match /incompatible types/
                    errors++
                    @writeLine compileError.split('\n')[0].bold.red
                if errors == 0
                    @writeLine 'syntax ok'.bold.green
                    action.run argv, file


    @watchDir: (argv, dir, callback) ->
        @writeLine 'watching ' + dir + ' directory for changes'
        watcher = hound.watch dir
        watcher.on 'change', callback
        watcher.on 'create', (file) ->
            if file.match /\.class$/
                
                #
                # successful compiles leave .class files in the src dir, delete
                #
                
                fs.unlink file, (err) ->  


    @run: (argv) -> 

        fs.stat './build.xml', (err, stats) => 
            if err and err.code == 'ENOENT'
                @writeLine 'expected ./build.xml file'.bold.red
            return if err 


            @watchDir argv, './src', (file, stats) => 
                if file.match /\.java$/
                    @writeLine ('detected changed file: ' + file).bold.white
                    @compile argv, file


