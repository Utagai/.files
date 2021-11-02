#!/usr/bin/python

import sys
import os.path
import platform
from subprocess import Popen, PIPE
from fruity import prnt

MAX_PREVIEW_CHARS = 100

def get_copy_cmd():
    if is_WSL():
        return "clip.exe"
    elif platform.system() == "Darwin":
        return "pbcopy"
    else:
        return "xsel -ib"

def is_WSL():
    osrelease_file = "/proc/sys/kernel/osrelease"
    if not os.path.isfile(osrelease_file):
        return

    with open(osrelease_file) as osrelease_file:
        osrelease = osrelease_file.read()
        return "Microsoft" in osrelease

def report_copy(copy_txt):
    preview = copy_txt[:MAX_PREVIEW_CHARS]
    if len(copy_txt) > MAX_PREVIEW_CHARS:
        preview += "...".encode()
    prnt("Copied: {}".format(preview.decode()))


def main():
    try:
        copy_cmd = get_copy_cmd()
        piped_input = sys.stdin.read()
        str_to_copy = piped_input.encode().strip()
        xsel_proc = Popen(copy_cmd.split(), stdin=PIPE, stdout=PIPE)
        xsel_proc.communicate(str_to_copy)

        report_copy(str_to_copy)
    except Exception as e:
        print("Failed to copy: {}".format(e))

if __name__ == "__main__":
    main()
