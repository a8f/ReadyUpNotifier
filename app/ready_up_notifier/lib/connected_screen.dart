import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'utils.dart';

class ConnectedScreen extends StatelessWidget {
  final IOWebSocketChannel socket;

  ConnectedScreen({Key key, @required this.socket}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(APP_TITLE),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 2 / 3,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: socket.stream,
                      builder: socketStreamBuilder,
                    ))
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      socket.sink.add("ready up");
                    },
                    child: Text("Send test data"),
                  )
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      socket.sink.close(status.goingAway);
                      Navigator.pop(context);
                    },
                    child: Text(DISCONNECT_BUTTON_TEXT),
                  ),
                ),
              ],
            )
          ],
        )));
  }

  Widget socketStreamBuilder(context, snapshot) {
    String currentText = NO_CONNECTION_TEXT;
    Color color = DEFAULT_COLOR;
    if (snapshot.hasData) {
      switch (snapshot.data) {
        case "ready up":
          currentText = READY_UP_TEXT;
          color = READY_UP_COLOR;
          break;
        case "in queue":
          currentText = IN_QUEUE_TEXT;
          color = IN_QUEUE_COLOR;
          break;
        case "ready cancelled":
          currentText = READY_CANCELLED_TEXT;
          color = IN_QUEUE_COLOR;
          break;
        default:
          currentText = NO_CONNECTION_TEXT;
          currentText = snapshot.data;
      }
    }
    return RaisedButton(
        color: color,
        onPressed: null,
        child: Center(
            child: Text(currentText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold))));
  }
}
