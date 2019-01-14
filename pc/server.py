import re
from threading import Thread
from time import sleep
from websocket_server import WebsocketServer

#path = "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\csgo"
#ready_message_regex = r'Server reservation check (\w)* ready-up!'

class Server():
    connected = False
    match_found = False
    in_queue = False
    done = False
    notify = False

    def __init__(self, ready_regex=r'ready', cancel_regex=r'cancel', queue_regex=r'queue', ip='localhost', port=1234, update_rate=1, path='.', logfile='console.log'):
        self.path = "."
        self.ready_regex = ready_regex
        self.cancel_regex = cancel_regex
        self.queue_regex = queue_regex
        self.ip = ip
        self.port = port
        self.update_rate = update_rate
        self.path = path
        self.logfile = logfile
        self.socket = None

    def update_log(self):
        with open(self.path + "/console.log", "r") as f:
            f.seek(0,2) # Go to end of file
            while not self.done:
                line = f.readline()
                if not line:
                    sleep(self.update_rate)
                    continue
                if self.match_found and re.match(self.cancelled_regex, line):
                    self.match_found = False
                    self.socket.send_message_to_all("cancel")
                    continue
                if re.match(self.ready_regex, line):
                    self.match_found = True
                    self.socket.send_message_to_all("ready")
                    continue
                if re.match(self.queue_regex, line):
                    self.socket.send_message_to_all("queue")
                    self.in_queue = True
                    continue

    def serve(self):
        self.socket.serve_forever()

    def on_message(self, client, server, message):
        self.socket.send_message_to_all(message)

    def on_client_join(self, client, server):
        print("Client {} connected".format(client["id"]))
        self.connected = True
        if self.match_found:
            self.socket.send_message_to_all("ready")
        elif self.in_queue:
            self.socket.send_message_to_all("queue")
        else:
            self.socket.send_message_to_all("waiting")

    def on_client_leave(self, client, server):
        print("Client {} disconnected".format(client["id"]))
        self.connected = False

    def stop(self):
        print("Exiting")
        self.done = True
        self.socket.shutdown()

    def start(self):
        self.socket = WebsocketServer(self.port, host=self.ip)
        self.socket.set_fn_message_received(self.on_message)
        self.socket.set_fn_new_client(self.on_client_join)
        self.socket.set_fn_client_left(self.on_client_leave)
        server_thread = Thread(target=self.serve)
        server_thread.start()
        print("Awaiting connection")
        self.update_log()
        server_thread.join()
