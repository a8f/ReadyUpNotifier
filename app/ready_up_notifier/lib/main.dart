import 'package:flutter/material.dart';
import 'utils.dart';
import 'server_select.dart';

void main() {
  initAndRun();
}

Future initAndRun() async {
  await SyncSharedPreferences.loadSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: APP_TITLE, home: ServerSelectScreen());
  }
}
