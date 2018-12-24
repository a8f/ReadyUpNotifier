import 'package:flutter/material.dart';

const String DEFAULT_PORT = "1234";
const String DEFAULT_IP = "10.0.2.2";
const String APP_TITLE = "ReadyUpNotifier";
const String DISCONNECT_BUTTON_TEXT= "Disconnect";
const String NO_CONNECTION_TEXT = "Unable to connect";
const String WAITING_FOR_QUEUE_TEXT = "Waiting for you to queue";
const String IN_QUEUE_TEXT = "In queue...";
const String READY_UP_TEXT = "Ready Up!";
const String READY_CANCELLED_TEXT = "Scratch that.\n" + IN_QUEUE_TEXT;
const String WAITING_TEXT = "Waiting for you to queue";
const Color READY_UP_COLOR = Color.fromRGBO(0, 255, 0, 1);
const Color IN_QUEUE_COLOR = Color.fromRGBO(225, 225, 66, 1);
const Color DEFAULT_COLOR = Color.fromRGBO(255, 25, 0, 1);
const Color WAITING_COLOR = Color.fromRGBO(50, 50, 50, 1);
const EdgeInsets CONNECT_FORM_PADDING = EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets CONNECT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);
const String ipRegex = r"(\d{1,3}\.){3}\d{1,3}";

bool isDeviceOnNetwork(String ip) {
  // TODO check if device is on network
  return true;
}

