import re
from threading import Thread
import asyncio
import websockets

UPDATE_RATE = 1
WAITING_FOR_MATCH = "waiting"
MATCH_FOUND = "match found"
MATCH_CANCELLED = "match cancelled"

# TODO find path depending on os or prompt for path
#path = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"
path = "."
ready_message_regex = r'Server reservation check (\w)* ready-up!'
cancelled_message_regex = r''
loop = asyncio.get_event_loop()
event_queue = asyncio.Queue(loop=loop)

async def update_log():
    await event_queue.put(WAITING_FOR_MATCH)
    with open(path + "/console.log", "r") as f:
        #f.seek(0,2) # Go to end of file
        while True:
            line = f.readline()
            if not line:
                time.sleep(UPDATE_RATE)
                continue
            if match_found and re.match(cancelled_message_regex, line):
                match_found = False
                await event_queue.put(MATCH_CANCELLED)
                continue
            if re.match(ready_message_regex, line):
                match_found = True
                await event_queue.put(MATCH_FOUND)

async def send_results(websocket, path):
    print("starting")
    while True:
        message = await event_queue.get()
        print("sending " + message)
        await websocket.send(message)

'''
if __name__ == '__main__':
    server_thread = Thread(target=run_server)
    server_thread.start()
    #update_log()
    server_thread.join()
'''


start_server = websockets.serve(send_results, 'localhost', 8765)
loop.run_until_complete(start_server)
loop.run_forever()