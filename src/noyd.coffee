argv = require('optimist')

    .usage( 

        """
        Filter output from adb logcat.

        Usage: noyd -t YourLogTag
        """
    )

    #
    # specify the 
    #

    .demand('t')
    .alias('t', 'tag')
    .describe('t','Specify your adb logcat tag (to highlight)')

    .boolean('s')
    .alias('s','silent')
    .describe('s','Only show matches and exceptions')

    .argv

module.exports = 

    run: -> 

        require('./logcat').run argv

