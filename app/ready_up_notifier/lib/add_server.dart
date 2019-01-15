import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'connected_screen.dart';
import 'utils.dart';
import 'server.dart';

class AddServerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: ConnectForm(),
    );
  }
}

class ConnectForm extends StatefulWidget {
  @override
  ConnectFormState createState() {
    return ConnectFormState();
  }
}

class ConnectFormState extends State<ConnectForm> {
  final _formKey = GlobalKey<FormState>();
  final ipController = TextEditingController();
  final portController = TextEditingController();
  final portFocusNode = new FocusNode();
  final nicknameController = TextEditingController();
  final nicknameFocusNode = new FocusNode();

  @override
  void dispose() {
    ipController.dispose();
    portController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  Server saveServer() {
    // Hide keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      // Save new server if it doesn't exist
      Server newServer = new Server(ipController.text);
      if (portController.text.isNotEmpty) {
        newServer.port = int.parse(portController.text);
      }
      if (nicknameController.text.isNotEmpty) {
        newServer.nickname = nicknameController.text;
      }
      List<Server> savedServers = getSavedServers();
      if (savedServers.contains(newServer)) {
        // TODO show message that server already exists
        return null;
      }
      savedServers.add(newServer);
      SyncSharedPreferences.sharedPreferences
          .setStringList("servers", serverListToStringList(savedServers));
      return newServer;
    }
    return null;
  }

  void saveAndBack() {
    if (saveServer() != null) {
      Navigator.pop(context);
    }
  }

  void saveAndConnect() {
    Server newServer = saveServer();
    if (newServer != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConnectedScreen(server: newServer)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: CONNECT_FORM_PADDING,
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: ipController,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    hintText: DEFAULT_IP, labelText: "IP Address"),
                onFieldSubmitted: (String value) {
                  if (value.isEmpty) ipController.text = DEFAULT_IP;
                  FocusScope.of(context).requestFocus(portFocusNode);
                },
                validator: (value) {
                  if (new RegExp(ipRegex).allMatches(value).isEmpty) {
                    return "Invalid IP";
                  }
                  if (!isDeviceOnNetwork(value)) {
                    return "Couldn't connect to host " + value;
                  }
                },
              ),
              TextFormField(
                  controller: portController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: portFocusNode,
                  onFieldSubmitted: (value) {
                    if (value.isEmpty)
                      portController.text = DEFAULT_PORT.toString();
                    FocusScope.of(context).requestFocus(nicknameFocusNode);
                  },
                  decoration: new InputDecoration(
                      hintText: DEFAULT_PORT.toString(), labelText: "Port"),
                  validator: (value) {
                    if (new RegExp(r"\d{1,5}").allMatches(value).isEmpty) {
                      return "Invalid port";
                    }
                  }),
              TextFormField(
                  controller: nicknameController,
                  textInputAction: TextInputAction.done,
                  focusNode: nicknameFocusNode,
                  onFieldSubmitted: (value) {
                    if (value.isEmpty)
                      nicknameController.text = ipController.text;
                    saveAndBack();
                  },
                  decoration: new InputDecoration(
                      hintText: "PC", labelText: "Nickname")),
              Padding(
                  padding: CONNECT_BUTTON_PADDING,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                          onPressed: saveAndBack, child: Text(SAVE_TEXT)),
                      RaisedButton(
                          onPressed: saveAndConnect,
                          child: Text(SAVE_AND_CONNECT_TEXT))
                    ],
                  )),
            ],
          ),
        )));
  }
}
