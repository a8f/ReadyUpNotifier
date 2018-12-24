import re
from threading import Thread
from time import sleep
from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket

# TODO find path depending on os or prompt for path
#path = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"
path = "."
#ready_message_regex = r'Server reservation check (\w)* ready-up!'
ready_message_regex = r'ready'
cancelled_message_regex = r'cancel'
queue_message_regex = r'queue'
ip = "localhost"
port = 1234
update_rate = 1
client = None
connected = False
done = False
match_found = False
in_queue = False

def update_log():
    global match_found, done, connected, client
    with open(path + "/console.log", "r") as f:
        #f.seek(0,2) # Go to end of file
        while True:
            line = f.readline()
            if not line:
                sleep(update_rate)
                continue
            if match_found and re.match(cancelled_message_regex, line):
                match_found = False
                client.sendMessage("cancel")
                continue
            if re.match(ready_message_regex, line):
                match_found = True
                client.sendMessage("ready")
                continue
            if re.match(queue_message_regex, line):
                client.sendMessage("queue")
                in_queue = True
                continue

class Server(WebSocket):
    def handleMessage(self):
        self.sendMessage(self.data)

    def handleConnected(self):
        global connected, client, match_found, in_queue
        client = self
        connected = True
        print(self.address, " connected")
        if match_found:
            self.sendMessage("ready")
        elif in_queue:
            self.sendMessage("queue")
        else:
            self.sendMessage("waiting")

    def handleClose(self):
        global done
        #done = True
        print(self.address, " closed")

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
    while not connected: pass
    print("connected\n")
    update_log()
    server_thread.join()
    print("done")
