#!/usr/bin/env python3

from server import Server
import argparse

parser = argparse.ArgumentParser(description="Local server to send app notifications")
parser.add_argument('--ip', type=str, nargs='?', help='IP address to host on')
parser.add_argument('--port', type=int, nargs='?', help='Port to host on')
parser.add_argument('--logfile', type=str, nargs='?', help='Game log file')
args = parser.parse_args()
s = Server(*vars(args))
try:
    s.start()
except KeyboardInterrupt:
    s.stop()
    raise SystemExit
