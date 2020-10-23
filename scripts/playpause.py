#!/usr/bin/env python3

# This may just be the dumbest thing I have ever written.

import i3ipc
from pyautogui import press

i3 = i3ipc.Connection()
workspaces = i3.get_workspaces()
for i, workspace in enumerate(workspaces):
    if workspace.focused:
        current_workspace = i
        break

i3.command("workspace 4")

press("space")

i3.command("workspace {}".format(current_workspace + 1))
