import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'utils.dart';

class ConnectedScreen extends StatelessWidget {
  final IOWebSocketChannel socket;

  ConnectedScreen({Key key, @required this.socket}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              socket.sink.close();
              Navigator.pop(context, true);
            },
          ),
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
      }
    }
    return Center(
        child: Container(
            color: color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
            )));
  }
}
