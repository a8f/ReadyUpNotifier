import 'package:flutter/material.dart';
import 'utils.dart';

class ConnectedScreen extends StatelessWidget {
  final ServerConnection connection;

  ConnectedScreen({Key key, @required this.connection}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
            // cancel
          },
          child: Text(DISCONNECT_STR),
        ),
      ),
    );
  }
}