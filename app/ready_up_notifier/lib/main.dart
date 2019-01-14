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
    final appTitle = APP_TITLE;
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: ServerSelect(),
      ),
    );
  }
}
