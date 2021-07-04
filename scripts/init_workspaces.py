#!/usr/bin/python

import i3ipc
from time import sleep
from fruity import prnt, log
import subprocess
import socket

i3 = i3ipc.Connection()


class App:
    def __init__(self, name, cmd, args=""):
        self.name = name
        self.cmd = cmd
        self.args = args

    def _valid(self):
        rv = subprocess.Popen(
                ["which", self.cmd],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
        ).wait()
        return rv == 0

    def appName(self):
        return self.name

    def i3exec(self):
        if not self._valid():
            return
        reply = i3.command(self.execStr())[0] # Always only one command.
        sleep(1)
        response = {
                "success": reply.success
        }
        if not reply.success:
            response["error"] = reply.error
        return response

    def execStr(self):
        return 'exec {} {}'.format(self.cmd, self.args)


workspace_cmds = {
        'workspace 1': [App('Terminal', 'xst')],
        'workspace 2': [App('Browser', 'firefox')],
        'workspace 3': [App('Email', 'thunderbird')],
        'workspace 4': [App('Music', 'spotify')],
}

workspaces = sorted(workspace_cmds.keys())

if socket.gethostname() == "graphite":
    workspace_cmds['workspace 5'] = [App('Slack', 'slack')]

previous_workspace = None
for workspace in workspaces:
    apps = workspace_cmds[workspace]
    i3.command(workspace)
    for app in apps:
        base_msg = "{} with App: {}.".format(workspace.capitalize(), app.name)
        response = app.i3exec()
        if not response["success"]:
            prnt("Failed to set " + base_msg + ": " + response["error"])
            i3.command(previous_workspace)
            continue

        prnt("Set " + base_msg)
    sleep(1)
    previous_workspace = workspace

log("Workspaces initialized.")
