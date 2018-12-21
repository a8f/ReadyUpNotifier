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
          children: <Widget>[
            Row(
              children: <Widget>[
                StreamBuilder(
                  stream: socket.stream,
                  builder: socketStreamBuilder,
                )
              ],
            ),
            Row(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  socket.sink.add("Hello world");
                },
                child: Text("Send test data"),
              )
            ]),
            Row(
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
    if (!snapshot.hasData) {
      return Text("No data");
    }
    return Text(snapshot.data);
  }
}
