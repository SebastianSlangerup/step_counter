import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:step_counter/pages/home_page.dart';
import 'package:step_counter/pages/login_page.dart';
import 'package:step_counter/pages/signup_page.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatefulWidget {
  late SharedPreferences preferences;
  MyApp(this.preferences, {super.key});

  @override
  State<MyApp> createState() => MyAppState();
  
  static MyAppState of(BuildContext context) =>
    context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
      setState(() {
        _themeMode = themeMode;
      });
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = widget.preferences.getBool('isDarkMode');
    if (isDarkMode == null) {
      _themeMode = ThemeMode.system;
    } else {
      isDarkMode
          ? _themeMode = ThemeMode.dark
          : _themeMode = ThemeMode.light;
    }

    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      title: 'Step Counter',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}

