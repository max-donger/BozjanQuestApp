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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
          ),
        ),
      ),
    );
  }
}
