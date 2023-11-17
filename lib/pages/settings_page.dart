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
      body: Settings(context),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings(BuildContext context, {super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    initDefaultValues(context);
  }

  bool _darkMode = false;
  bool _isMetric = true;
  List<String> walkingPace = ["Slow", "Average", "Fast"];
  String selection = "";

  void initDefaultValues(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return;

    var isDarkMode = prefs.getBool('isDarkMode');
    var isMetric = prefs.getBool('isMetric') ?? true;
    selection = prefs.getString('selection') ?? walkingPace.first;
    var brightness = MediaQuery.platformBrightnessOf(context);

    // DARK MODE SWITCH
    if (isDarkMode == null) {
      changeTheme(brightness == Brightness.dark, context);
    } else {
      changeTheme(isDarkMode, context);
    }

    // METRIC SWITCH
    setState(() {
      _isMetric = isMetric;
    });
  }

  void changeTheme(bool isDarkMode, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return;

    setState(() {
      _darkMode = isDarkMode;
    });
    prefs.setBool('isDarkMode', isDarkMode);

    isDarkMode
        ? MyApp.of(context).changeTheme(ThemeMode.dark)
        : MyApp.of(context).changeTheme(ThemeMode.light);
  }

  void changeDistanceType(bool isMetric) async {
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return;

    setState(() {
      _isMetric = isMetric;
    });
    prefs.setBool('isMetric', isMetric);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Dark Mode'),
            trailing: IosSwitch(
              isEnabled: _darkMode,
              onChanged: (value) {
                changeTheme(value, context);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Use Metric?'),
            trailing: IosSwitch(
              isEnabled: _isMetric,
              onChanged: (value) {
                changeDistanceType(value);
              },
            ),
          ),
          const Divider(),
          ListTile(
              title: const Text('Walking pace'),
              trailing: CustomDropDownMenu(
                myList: walkingPace,
                currentSelection: selection
              )),
        ],
      ),
    );
  }
}
