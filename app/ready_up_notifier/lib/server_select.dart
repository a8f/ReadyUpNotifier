import 'package:flutter/material.dart';
import 'add_server.dart';
import 'utils.dart';
import 'server.dart';
import 'connected_screen.dart';

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

  @override
  void initState() {
    super.initState();
    loadServers();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: this.getServerWidgets());
  }

  List<Widget> getServerWidgets() {
    loadServers();
    List<Widget> widgets = new List<Widget>();
    for (Server s in servers) {
      widgets.add(ListTile(
          onTap: () => connectToServer(s),
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
