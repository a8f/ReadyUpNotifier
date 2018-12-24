import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'connected_screen.dart';
import 'utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = APP_TITLE;

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: ConnectForm(),
      ),
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

  void submitForm() {
    if (_formKey.currentState.validate()) {
      // hide keyboard
      FocusScope.of(context).requestFocus(new FocusNode());
      // try to connect
      var socket = IOWebSocketChannel.connect("ws://" + ipController.text + ":" + portController.text);
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
        child: Center(child:
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: ipController,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(hintText: DEFAULT_IP, labelText: "IP Address"),
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
                    if (value.isEmpty) portController.text = DEFAULT_PORT;
                    submitForm();
                  },
                  decoration:
                      new InputDecoration(hintText: DEFAULT_PORT, labelText: "Port"),
                  validator: (value) {
                    if (new RegExp(r"\d{1,5}").allMatches(value).isEmpty) {
                      return "Invalid port";
                    }
                  }),
              Padding(
                padding: CONNECT_BUTTON_PADDING,
              child: RaisedButton(
                onPressed: () {
                  submitForm();
                },
                child: Text('Connect'),
              ),
              )
            ],
          ),
        )
    ));
  }
}
