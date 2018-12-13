import re
from threading import Thread

UPDATE_RATE = 1

# TODO find path depending on os or prompt for path
path = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"
ready_message_regex = r'Server reservation check (\w)* ready-up!'
cancelled_message_regex = r''
match_found = False
joined = False

with open(path + "/console.log", "r") as f:
    f.seek(0,2) # Go to end of file
    while True:
        line = f.readline()
        if not line:
            time.sleep(UPDATE_RATE)
            continue
        if match_found and re.match(cancelled_message_regex, line):
            match_found = False
            continue
        if re.match(ready_message_regex, line):
            match_found = True
            Thread(target=notify).start()

def notify():
    # TODO send initial notification
    while not joined:
        if not match_found:
            # TODO send notification of match cancelled
            pass
    # TODO send notification of match started