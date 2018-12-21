import 'package:flutter/material.dart';

const String DEFAULT_PORT = "1234";
const String DEFAULT_IP = "10.0.2.2";
const String APP_TITLE = "ReadyUpNotifier";
const String DISCONNECT_BUTTON_TEXT= "Disconnect";
const String READY_UP_TEXT = "Ready Up!";
const String IN_QUEUE_TEXT = "In queue";
const String WAITING_FOR_QUEUE_TEXT = "Waiting for you to queue";
const EdgeInsets CONNECT_FORM_PADDING = EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0);
const EdgeInsets CONNECT_BUTTON_PADDING = EdgeInsets.symmetric(vertical: 16.0);
const String ipRegex = r"(\d{1,3}\.){3}\d{1,3}";

bool isDeviceOnNetwork(String ip) {
  // TODO check if device is on network
  return true;
}

