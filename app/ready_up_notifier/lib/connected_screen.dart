import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'utils.dart';

class ConnectedScreen extends StatefulWidget {
  final IOWebSocketChannel socket;
  ConnectedScreen({Key key, @required this.socket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ConnectedScreenState(socket);
  }
}

class ConnectedScreenState extends State<ConnectedScreen> {
  final IOWebSocketChannel socket;
  bool newlyConnected = true;
  bool notificationsEnabled = true;
  String firebaseToken;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  ConnectedScreenState(this.socket);

  @override
  void initState() {
    super.initState();
    createFirebaseListeners();
  }

  @override
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

  void createFirebaseListeners() {
    _firebaseMessaging.getToken().then((token) {
      this.firebaseToken = token;
      print("Token: $token");
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("Message: $message");
    }, onResume: (Map<String, dynamic> message) async {
      print("Resume: $message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("Launch: $message");
    });
  }

  void toggleNotifications(bool enableNotifications) {
    // TODO tell server to toggle notifications
    notificationsEnabled = enableNotifications;
  }

  Widget socketStreamBuilder(context, snapshot) {
    String currentText = NO_CONNECTION_TEXT;
    Color color = DEFAULT_COLOR;
    if (snapshot.hasData) {
      switch (snapshot.data) {
        case "waiting":
          if (newlyConnected) {
            currentText = CONNECTED_TEXT + "\n" + WAITING_TEXT;
            newlyConnected = false;
          } else {
            currentText = WAITING_TEXT;
          }
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
                            style: CONNECTION_STATUS_TEXT_STYLE)),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.8,
                        child: Switch(
                          value: notificationsEnabled,
                          onChanged: toggleNotifications,
                        ),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "\n" + NOTIFICATIONS_TOOLTIP,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    ])
              ],
            )));
  }
}
