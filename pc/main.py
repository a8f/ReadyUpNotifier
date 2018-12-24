from server import Server

s = Server(ip="localhost", port=1234)
try:
    s.start()
except KeyboardInterrupt:
    s.stop()
    raise SystemExit
