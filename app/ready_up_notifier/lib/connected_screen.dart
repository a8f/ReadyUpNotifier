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
        body: StreamBuilder(
          stream: socket.stream,
          builder: socketStreamBuilder,
        ));
  }

  Widget socketStreamBuilder(context, snapshot) {
    String currentText = NO_CONNECTION_TEXT;
    Color color = DEFAULT_COLOR;
    if (snapshot.hasData) {
      switch (snapshot.data) {
        case "waiting":
          currentText = WAITING_TEXT;
          color = WAITING_COLOR;
          break;
        case "ready":
          currentText = READY_UP_TEXT;
          color = READY_UP_COLOR;
          break;
        case "queue":
          currentText = IN_QUEUE_TEXT;
          color = IN_QUEUE_COLOR;
          break;
        case "cancel":
          currentText = READY_CANCELLED_TEXT;
          color = IN_QUEUE_COLOR;
          break;
        default:
          currentText = NO_CONNECTION_TEXT;
          currentText = snapshot.data;
      }
    }
    return Center(
        child: Container(
            color: color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 2 / 3 * MediaQuery.of(context).size.height,
                        child: Text(currentText,
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        socket.sink.close(status.goingAway);
                        Navigator.pop(context);
                      },
                      child: Text(DISCONNECT_BUTTON_TEXT),
                    ),
                  ],
                )
              ],
            )));
  }
}
