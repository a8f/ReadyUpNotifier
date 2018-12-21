import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectedScreen extends StatelessWidget {
  final IOWebSocketChannel socket;

  ConnectedScreen({Key key, @required this.socket}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            StreamBuilder(
              stream: socket.stream,
              builder: socketStreamBuilder,
            )
          ],
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                socket.sink.add("Hello world");
              },
              child: Text("Send test data"),
            )
          ]
        ),
        Row(
          children: <Widget>[
            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // cancel
                },
                child: Text(DISCONNECT_BUTTON_TEXT),
              ),
            ),
          ],
        )
      ],)
    );
  }

  Widget socketStreamBuilder (context, snapshot) {
    if (!snapshot.hasData) {
      return Text("No data");
    }
    return Text(snapshot.data);
  }
}