import subprocess
import os
import socket

notif_sh_path = 'dotfiles/scripts/notif.sh'
log_sh_path = 'dotfiles/scripts/log.sh'


def log(msg):
    log = subprocess.Popen(
            [
                os.path.join(os.path.expanduser("~"), log_sh_path),
                msg
            ]
    )
    log.wait()


def prnt(msg, header=socket.gethostname()):
    notif = subprocess.Popen(
            [
                os.path.join(os.path.expanduser("~"), notif_sh_path),
                msg,
                header
            ]
    )
    notif.wait()
    log("Notification fired: Header='{}' Message='{}'.".format(header, msg))
