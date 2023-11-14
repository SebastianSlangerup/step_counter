import 'package:flutter/material.dart';
import 'package:step_counter/components/ios_switch.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool darkmode = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Dark Mode'),
            trailing: IosSwitch(
              isEnabled: darkmode,
              onChanged: (value) { // Pass the function here
                setState(() {
                  darkmode = value;
                });
              },
            ),
          ),
          Divider(),
          
        ],
      ),
    );
  }
}

