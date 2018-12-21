import re
from threading import Thread
from time import sleep
from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket
from server import Server

WAITING_FOR_MATCH = "waiting"
MATCH_FOUND = "match found"
MATCH_CANCELLED = "match cancelled"

# TODO find path depending on os or prompt for path
#path = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"
path = "."
ready_message_regex = r'Server reservation check (\w)* ready-up!'
cancelled_message_regex = r''
ip = "localhost"
port = 1234
update_rate = 1000
client = None
connected = False
done = False

def update_log():
    with open(path + "/console.log", "r") as f:
        #f.seek(0,2) # Go to end of file
        while True:
            line = f.readline()
            if not line:
                sleep(update_rate)
                continue
            if match_found and re.match(cancelled_message_regex, line):
                match_found = False
                continue
            if re.match(ready_message_regex, line):
                match_found = True


class Server(WebSocket):
    def handleMessage(self):
        self.sendMessage(self.data)
    
    def handleConnected(self):
        global connected, client
        client = self
        connected = True
        print(self.address, "connected")
    
    def handleClose(self):
        global done
        done = True
        print(self.address, "closed")

def serve():
    global done
    while not done:
        server.serveonce()

if __name__ == '__main__':
    server = SimpleWebSocketServer(ip, port, Server)
    #Thread(target=server.serveforever).start()
    server_thread = Thread(target=serve)
    server_thread.start()
    print("awaiting connection\n")
    while not connected:
        pass
    client.sendMessage("test")
    #update_log()
    server_thread.join()