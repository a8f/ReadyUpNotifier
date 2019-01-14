import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncSharedPreferences {
  static SharedPreferences sharedPreferences;
  static Future loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

const int DEFAULT_PORT = 12345;
const String DEFAULT_IP = "10.0.2.2";
const String APP_TITLE = "ReadyUpNotifier";
const String DISCONNECT_BUTTON_TEXT = "Disconnect";
const String NO_CONNECTION_TEXT = "Unable to connect";
const String CONNECTED_TEXT = "Connected";
const String WAITING_TEXT = "Queue now";
const String IN_QUEUE_TEXT = "In queue...";
const String READY_UP_TEXT = "Ready Up!";
const String READY_CANCELLED_TEXT = "Scratch that.\n" + IN_QUEUE_TEXT;
const String NOTIFICATIONS_TOOLTIP = "Notify while in background";
const Color READY_UP_COLOR = Color.fromRGBO(0, 255, 0, 1);
const Color IN_QUEUE_COLOR = Color.fromRGBO(225, 225, 66, 1);
const Color DEFAULT_COLOR = Color.fromRGBO(255, 25, 0, 1);
const Color WAITING_COLOR = Color.fromRGBO(40, 60, 200, 1);
const EdgeInsets CONNECT_FORM_PADDING =
    EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets CONNECT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);
const String ipRegex = r"(\d{1,3}\.){3}\d{1,3}";

bool isDeviceOnNetwork(String ip) {
  // TODO check if device is on network
  return true;
}

class Server {
  String nickname;
  String ip;
  int port;
  static String stringDelimeter =
      "/~~/"; // Delimeter for converting to/from string

  static Server fromString(String serverString) {
    List<String> info = serverString.split(stringDelimeter);
    return Server(info[0], port: int.parse(info[1]), nickname: info[2]);
  }

  Server(String ip, {String nickname, int port}) {
    this.ip = ip;
    this.port = port == null ? DEFAULT_PORT : port;
    this.nickname =
        nickname == null ? ip.toString() + ":" + port.toString() : nickname;
  }

  String toString() {
    return ip + stringDelimeter + port.toString() + stringDelimeter + nickname;
  }
}

List<String> serverListToStringList(List<Server> servers) {
  List<String> stringList = new List<String>();
  for (Server s in servers) {
    stringList.add(s.toString());
  }
  return stringList;
}

List<Server> stringListToServerList(List<String> servers) {
  List<Server> serverList = new List<Server>();
  for (String s in servers) {
    serverList.add(Server.fromString(s));
  }
  return serverList;
}
