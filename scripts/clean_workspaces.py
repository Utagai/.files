#!/usr/bin/python

from subprocess import Popen, PIPE
import os
import signal

from fruity import prnt, log


# Gets all open windows with their PIDs.
wmctrl_lp = Popen(['wmctrl', '-lp'], stdout=PIPE, stderr=PIPE)

out, err = [data.decode('utf-8') for data in wmctrl_lp.communicate()]

out_lines = out.split('\n')

window_pids = []
for line in out_lines:
    if line:  # There are sometimes blank lines in wmctrl's output...
        window_pids.append(int(line.split()[2]))

print("Window PIDs: {}".format(window_pids))
window_titles = [
        "* " + line.split()[-1] + " (" + str(window) + ")"
        for line, window
        in zip(out_lines, window_pids)
        if line
]

for pid in window_pids:
    os.kill(pid, signal.SIGTERM)

window_kill_msg = "\n".join(window_titles)
prnt("Killed all existing windows:\n{}".format(window_kill_msg))
log("Killed windows for cleaning:\n{}".format(window_kill_msg))
