import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'utils.dart';

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
    return ListView(
        padding: EdgeInsets.all(4.0),
        itemExtent: 20.0,
        children: this.getServerWidgets());
  }

  List<Widget> getServerWidgets() {
    List<Widget> widgets = new List<Widget>();
    for (Server s in servers) {
      widgets.add(Text(s.nickname));
    }
    widgets.add(Text("Add new server"));
    return widgets;
  }

  void loadServers() {
    List<String> serverStringList =
        SyncSharedPreferences.sharedPreferences.getStringList("servers");
    if (serverStringList == null) {
      servers = new List<Server>();
    } else {
      servers = stringListToServerList(
          SyncSharedPreferences.sharedPreferences.getStringList("servers"));
    }
  }

  void saveServers() {
    SyncSharedPreferences.sharedPreferences
        .setStringList("servers", serverListToStringList(servers));
  }
}
