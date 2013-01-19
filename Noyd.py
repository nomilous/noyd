
#
# sublime plugin - writes response from an async thread onto
#                  the first line of the file in the view 
#                  that ran it.
# 
# 
# 
# Library/Application Support/Sublime Text 2/Packages/Noyd/Noyd.py
# (to open sublime console)         ctrl `  
# (to run the plugin from console)  view.run_command('noyd')
# 
# http://net.tutsplus.com/tutorials/python-tutorials/how-to-create-a-sublime-text-2-plugin/
# 



import sublime
import sublime_plugin
import threading


class NoydCommand(sublime_plugin.TextCommand):
    
    def run(self, edit):

        #
        # start a thread
        #

        thread = NoydApiCall()
        thread.start()
        self.thread_result(edit, thread)

        

    def thread_result(self, edit, thread):

        if thread.result != False:

            #
            # got result from thread...
            # 
            # write to status bar
            # and insert result text at the top of the file...
            #

            self.view.set_status('Noyd', 'got result... ')
            self.view.insert(edit, 0, thread.result)
            return

        else:

            #
            # not result yet... 
            # 
            # check again in 10th of a second
            #

            self.view.set_status('Noyd', 'no result yet... ')
            sublime.set_timeout(lambda: self.thread_result(edit, thread), 100)




class NoydApiCall(threading.Thread):
    
    def __init__(self):

        threading.Thread.__init__(self)

    def respond(self):

        #
        # populate result
        #

        self.result = "# inserted at top of current file... \n"


    def run(self):

        self.result = False

        #
        # wait 10 seconds before result
        #

        sublime.set_timeout(lambda: self.respond(), 10000)


