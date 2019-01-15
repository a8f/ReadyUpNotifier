import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Wrapper for accessing SharedPreferences synchronously
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
const TextStyle CONNECTION_STATUS_TEXT_STYLE =
    TextStyle(fontSize: 48, fontWeight: FontWeight.bold);
const TextStyle CONNECTION_LIST_ENTRY_TEXT_STYLE =
    TextStyle(fontSize: 34, fontWeight: FontWeight.bold);
const Color CONNECTION_LIST_ENTRY_BG_COLOR = Color.fromRGBO(200, 200, 200, 1);
const String NEW_SERVER_TEXT = "New Server";
const String SAVE_TEXT = "Save";
const String SAVE_AND_CONNECT_TEXT = "Save & Connect";

bool isDeviceOnNetwork(String ip) {
  // TODO check if device is on network
  return true;
}
