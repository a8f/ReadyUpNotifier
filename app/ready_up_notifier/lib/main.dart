import 'package:flutter/material.dart';
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

// Create a Form Widget
class ConnectForm extends StatefulWidget {
  @override
  ConnectFormState createState() {
    return ConnectFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class ConnectFormState extends State<ConnectForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              labelText: "IP Address"
            ),
            validator: (value) {
              if (!isValidIP(value)) {
                return "Invalid IP";
              }
              if (!isDeviceOnNetwork(value)) {
                return "Couldn't connect to host " + value;
              }
            },
          ),
          new TextFormField(
            decoration: new InputDecoration(
              hintText: "5000",
              labelText: "Port"
            ),
            validator: (value) {
              if (value.isEmpty) {
                value = DEFAULT_PORT;
              }
              if (!isValidPort(value)) {
                return "Invalid port";
              }
            }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Connecting')));
                  
                }
              },
              child: Text('Connect'),
            ),
          ),
        ],
      ),
    );
  }
}