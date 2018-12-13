const String DEFAULT_PORT = "5000";
const String APP_TITLE = "ReadyUpNotifier";

bool isValidIP(String ip) {
  // TODO get local ip and check that the specified IP matches
  return ip.isNotEmpty;
}

bool isValidPort(String port) {
  // TODO validate port
  return port.isNotEmpty;
}

bool isDeviceOnNetwork(String ip) {
  // TODO check if device is on network
  return true;
}

class ServerConnection {
  String ip;
  String port;
  bool awaitingReady = false;
  bool connected = false;

  ServerConnection(String ip, String port) {
    this.ip = ip;
    this.port = port;
  }

  bool establishConnection() {
    // TODO establish connection
    connected = true;
    return true;
  }

  bool isAwaitingReady() {
    // TODO update ready up status from server
    return awaitingReady;
  }

  bool isConnected() {
    // TODO make sure connection is valid and update connected appropriately
    return connected;
  }
}