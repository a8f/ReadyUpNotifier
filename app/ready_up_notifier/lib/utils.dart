import 'package:flutter/material.dart';
const String DEFAULT_PORT = "5000";
const String APP_TITLE = "ReadyUpNotifier";
const String DISCONNECT_BUTTON_TEXT= "Disconnect";
const String READY_UP_TEXT = "Ready Up!";
const String IN_QUEUE_TEXT = "In queue";
const String WAITING_FOR_QUEUE_TEXT = "Waiting for you to queue";
const EdgeInsets CONNECT_FORM_PADDING = EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets CONNECT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);



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

  String establishConnection() {
    // TODO establish connection
    connected = false;
    return "Couldn't connect";
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