import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:step_counter/pages/user_page.dart';
import '../step_counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> _pageTitles = ['Settings', 'Home', 'User'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(_pageTitles[_selectedIndex].toString()),
        ),
        Container(
          alignment: Alignment.center,
          child: defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS ? const StepCounter() : Text("This is a crime")
        ),
        Container(
          alignment: Alignment.center,
          child: UserPage(),
        ),
      ][_selectedIndex],
    );
  }
}
