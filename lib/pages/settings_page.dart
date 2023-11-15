import 'package:flutter/material.dart';
import 'package:step_counter/components/ios_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
  
}

class _SettingsState extends State<Settings>{

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  bool _darkmode = true;

  void changeTheme(bool isDarkMode, BuildContext context) {
    if (isDarkMode) {
      _darkmode = true;
      MyApp.of(context).changeTheme(ThemeMode.dark);
    } else {
      _darkmode = false;
      MyApp.of(context).changeTheme(ThemeMode.light);
    }
  }

  Future<bool> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
      return _darkmode = prefs.getBool('darkmode') ?? false;
  }

  Future<void> _setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('darkmode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Dark Mode'),
            trailing: IosSwitch(
              isEnabled: _darkmode,
              onChanged: (value) { // Pass the function here
                setState(() {
                  _darkmode = value;
                  changeTheme(_darkmode, context);
                  _setTheme(_darkmode);
                });
              },
            ),
          ),
          const Divider(),
          
        ],
      ),
    );
  }
}

