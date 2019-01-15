import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'connected_screen.dart';
import 'utils.dart';

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

  @override
  void dispose() {
    ipController.dispose();
    portController.dispose();
    super.dispose();
  }

  bool saveServer() {
    if (_formKey.currentState.validate()) {
      // hide keyboard
      FocusScope.of(context).requestFocus(new FocusNode());
      // TODO save server if not exists
    }
  }

  void saveAndBack() {
    if (saveServer()) {
      Navigator.pop(context);
    }
  }

  void saveAndConnect() {
    if (saveServer()) {
      var socket = IOWebSocketChannel.connect(
          "ws://" + ipController.text + ":" + portController.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConnectedScreen(socket: socket)));
    }
  }

  void submitForm() {
    if (_formKey.currentState.validate()) {
      // hide keyboard
      FocusScope.of(context).requestFocus(new FocusNode());
      // try to connect
      var socket = IOWebSocketChannel.connect(
          "ws://" + ipController.text + ":" + portController.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConnectedScreen(socket: socket)));
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
              new TextFormField(
                  controller: portController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.go,
                  focusNode: portFocusNode,
                  onFieldSubmitted: (value) {
                    if (value.isEmpty)
                      portController.text = DEFAULT_PORT.toString();
                    submitForm();
                  },
                  decoration: new InputDecoration(
                      hintText: DEFAULT_PORT.toString(), labelText: "Port"),
                  validator: (value) {
                    if (new RegExp(r"\d{1,5}").allMatches(value).isEmpty) {
                      return "Invalid port";
                    }
                  }),
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
