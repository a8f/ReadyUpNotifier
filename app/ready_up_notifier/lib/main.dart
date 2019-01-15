import 'package:flutter/material.dart';
import 'utils.dart';
import 'server.dart';
import 'server_select.dart';

void main() {
  initAndRun();
}

Future initAndRun() async {
  await SyncSharedPreferences.loadSharedPreferences();
  //saveServers(new List<Server>()); // Uncomment to zero saved servers on startup
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: APP_TITLE, home: ServerSelectScreen());
  }
}
