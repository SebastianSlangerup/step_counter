import 'package:flutter/material.dart';
import 'package:step_counter/components/custom_dropdown.dart';
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
  }

  bool _darkmode = true;
  bool _isKm = true;

  List<String> pace = <String>['One', 'Two', 'Three', 'Four'];

  void changeTheme(bool isDarkMode, BuildContext context) {
    if (isDarkMode) {
      _darkmode = true;
      MyApp.of(context).changeTheme(ThemeMode.dark);
    } else {
      _darkmode = false;
      MyApp.of(context).changeTheme(ThemeMode.light);
    }
  }


  void changeDistanceType(bool isKm, BuildContext context) {
    if (isKm) {
      _isKm = true;
    } else {
      _isKm = false;
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

  Future<bool> _loadDistanceType() async {
    final prefs = await SharedPreferences.getInstance();
      return _isKm = prefs.getBool('isKm') ?? false;
  }

  Future<void> _setDistanceType(bool isKm) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isKm', isKm);
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
              onChanged: (value) {
                setState(() {
                  _darkmode = value;
                  changeTheme(_darkmode, context);
                  _setTheme(_darkmode);
                });
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('km/mil'),
            trailing: IosSwitch(
              isEnabled: _isKm,
              onChanged: (value) {
                setState(() {
                  _isKm = value;
                  changeDistanceType(_isKm, context);
                  _setDistanceType(_isKm);
                });
              },
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('Waking pace'),
            trailing: CustomDropDownMenu(
              mylist: ["Test","test2","test3"],
                    
            )
          ),
        ],
      ),
    );
  }
}

