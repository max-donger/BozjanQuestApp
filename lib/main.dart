import 'package:flutter/material.dart';

import 'tabs/top/learn_page.dart';
import 'tabs/top/bosses_page.dart';
import 'tabs/top/duels_page.dart';
import 'tabs/top/timers_page.dart';
import 'tabs/top/maps_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      // TODO: FIX THEME maybe like this https://stackoverflow.com/questions/50917350/custom-theme-not-working-properly-flutter  and add routes
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
    ),
  );
}

/// This is the stateful widget that the main application instantiates.
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyApp> {
  int _selectedIndex = 1; // Selects the second bottom tab
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: About',
      style: optionStyle,
    ),
    Text(
      'Index 1: Donate',
      style: optionStyle,
    ),
    Text(
      'Index 2: Code',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bozjan Quest',
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.menu_book), text: 'Learn'),
                Tab(icon: Icon(Icons.adb), text: 'Bosses'),
                Tab(icon: Icon(Icons.people), text: 'Duels'),
                Tab(icon: Icon(Icons.add_alarm), text: 'Timers'),
                Tab(icon: Icon(Icons.map), text: 'Maps'),
              ],
            ),
            title: Text('Bozjan.quest'),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              LearnPage(),
              BossesPage(),
              DuelsPage(),
              TimersPage(),
              MapsPage(),
            ],
            /* body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      */
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.alternate_email),
                label: 'About',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'Donate',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.code),
                label: 'Code',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
