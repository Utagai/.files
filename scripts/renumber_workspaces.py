#!/usr/bin/python

import i3ipc
import time
from fruity import prnt, log

i3 = i3ipc.Connection()

workspaces = i3.get_workspaces()

# We know with certainty that the workspace numbers are integers.
workspace_names = [int(workspace['name']) for workspace in workspaces]
max_workspace_num = max(workspace_names)


# Rename workspaces to a larger number to avoid rename conflicts.
def rename_workspaces(offset):
    for i, old_name in enumerate(workspace_names):
        new_name = i + offset + 1
        res = i3.command('rename workspace {} to {}'.format(
            old_name, new_name
            )
        )
        if not res[0]['success']:
            err_fmt = '[{} - renumber] Rename failed: "{} to {}" on {}.\n'
            err_msg = err_fmt.format(
                    time.strftime("%c"), old_name, new_name, workspace_names
            )
            err_msg += res[0]['error'] + '\n'
            log(err_msg)
        workspace_names[i] = new_name


rename_workspaces(max_workspace_num)
rename_workspaces(0)

prnt("Workspaces renumbered!")
