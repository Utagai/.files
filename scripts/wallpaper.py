#!/usr/bin/python

import subprocess
from fruity import prnt, log
import os
import argparse

# Set some needed constants and globals/whatnot.
HOME = os.path.expanduser('~')
FEH_OPTIONS = ['center', 'fill', 'max', 'scale', 'tile']
WALLPAPER_JPG_PATH = '{}/Pictures/wallpaper.jpg'.format(HOME)
FEH_CMD = "feh --bg-{} " + WALLPAPER_JPG_PATH

# Extract CLI arguments.
parser = argparse.ArgumentParser(description="Set the wallpaper on fruit.")
parser.add_argument(
        'image', type=str, help='The image to set as the new wallpaper.'
)
parser.add_argument(
        'fehmode',
        type=str,
        default='scale',
        nargs='?',
        help='The mode with which to set the wallpaper with feh.'
        + ' ({})'.format(",".join(FEH_OPTIONS))
)
args = parser.parse_args()

if args.fehmode not in FEH_OPTIONS:
    log("Invalid fehmode given: {}".format(args.fehmode))
    exit(0)


def convert(convert_cmd):
    log("Final convert cmd: {}".format(convert_cmd))
    conversion_proc = subprocess.Popen(convert_cmd)
    conversion_proc.wait()


# Transfer over the wallpaper to ~/Pictures/wallpaper.[jpg|png].
final_lock_convert_cmd = ["convert", args.image, WALLPAPER_JPG_PATH]
convert(final_lock_convert_cmd)

# Fire the FEH command to update the bg.
final_feh_cmd = FEH_CMD.format(args.fehmode).split()
log("Final feh cmd: {}".format(final_feh_cmd))
feh_proc = subprocess.Popen(final_feh_cmd)
feh_proc.wait()

# Notify.
prnt("Wallpaper changed!")
