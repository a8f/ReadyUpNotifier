import 'package:flutter/material.dart';
import 'add_server.dart';
import 'utils.dart';
import 'server.dart';
import 'connected_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ServerSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: ServerSelect(),
    );
  }
}

class ServerSelect extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ServerSelectState();
  }
}

class ServerSelectState extends State<ServerSelect> {
  List<Server> servers;

  String firebaseToken;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    loadServers();
    createFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: this.getServerWidgets());
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

  List<Widget> getServerWidgets() {
    loadServers();
    List<Widget> widgets = new List<Widget>();
    for (Server s in servers) {
      widgets.add(ListTile(
          onTap: () => connectToServer(s),
          onLongPress: () => editServer(s),
          title: Center(
              child:
                  Text(s.nickname, style: CONNECTION_LIST_ENTRY_TEXT_STYLE))));
    }
    widgets.add(ListTile(
        onTap: addNewServer,
        title: Center(
            child: Text(NEW_SERVER_TEXT,
                style: CONNECTION_LIST_ENTRY_TEXT_STYLE))));
    return widgets;
  }

  void connectToServer(Server server) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConnectedScreen(server: server)));
  }

  void editServer(Server server) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddServerScreen(serverId: server.id)));
  }

  void addNewServer() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddServerScreen(serverId: newServerId())));
  }

  void loadServers() {
    servers = getSavedServers();
  }

  void saveServers() {
    SyncSharedPreferences.sharedPreferences
        .setStringList("servers", serverListToStringList(servers));
  }
}
