import 'package:flutter/material.dart';

// Import top tabs
import 'tabs/top/learn_page.dart';
import 'tabs/top/bosses_page.dart';
import 'tabs/top/duel_page.dart';
import 'tabs/top/holster_page.dart';

// Import bottom tabs
import 'tabs/bottom/about_page.dart';
import 'tabs/bottom/settings_page.dart';

// void main() => runApp(Bozjan());

class Drs extends StatefulWidget {
  Drs({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Drs> {
  int _currentTopIndex = 0;
  int _currentBotIndex = 0;
  int _currentMergedIndex = 0;
  bool isSwitched = false;

  final List<Widget> _children = [
    LearnPage(),
    WeatherPage(),
    BossesPage(),
    DuelsPage(),
    AboutPage(),
    SettingsPage(),
  ];

  // Hide the topbar indicator color if the bottom navigation bar is used
  Color topBarIndicatorColor() {
    Color color = Colors.deepOrange;
    // TODO: set the 5 to a list count
    if (_currentMergedIndex >= 5) {
      color = Colors.transparent;
    } else {
      color = Colors.white;
    }
    return color;
  }

  // Hide the bottombar selectedItemColor if the top navigation bar is used
  Color bottomBarIndicatorColor() {
    Color color = Colors.deepOrange;
    // TODO: set the (0 to ) 4 to a list count
    if (_currentMergedIndex <= 4) {
      color = Colors.grey;
    } else {
      color = Colors.lightBlue;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Delubrum Reginae (Savage)'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.checklist), text: 'Getting started'),
                Tab(icon: Icon(Icons.business_center), text: 'Holster'),
                Tab(icon: Icon(Icons.adb), text: 'Bosses'),
                Tab(icon: Icon(Icons.people), text: 'Duel'),
                Tab(icon: Icon(Icons.map), text: 'Map'),
              ],
              onTap: onTopTabTapped,
              indicatorColor: topBarIndicatorColor(),
            ),
          ),
          body: _children[_currentMergedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onBotTabTapped,
            currentIndex: _currentBotIndex,
            selectedItemColor: bottomBarIndicatorColor(),
            unselectedFontSize: 14,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.alternate_email),
                label: 'About',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTopTabTapped(int index) {
    setState(
      () {
        _currentTopIndex = index;
        _currentMergedIndex = (_currentTopIndex);
        _currentBotIndex = 0; // Set the bot index back to Home
      },
    );
  }

  void onBotTabTapped(int index) {
    setState(
      () {
        _currentBotIndex = index;
        // TODO: set the 5 to a list count
        _currentMergedIndex = (_currentBotIndex + 5);
      },
    );
  }
}
