import 'package:flutter/material.dart';

// Import pages
import 'bozjan/bozjan.dart';
import 'zadnor/zadnor.dart';

// Import bottom tabs
/* import 'tabs/bottom/about_page.dart';
import 'tabs/bottom/donate_page.dart';
import 'tabs/bottom/settings_page.dart'; */

void main() => runApp(
      MaterialApp(
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Set a key so it can be used as context (to call the map Drawer)
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                scaffoldKey.currentState.openDrawer();
              },
            ),
            title: Text('bozjan.quest'),
          ),
          body: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('How to unlock'),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bozjan()),
                      );
                    },
                    child: const Text('Explore Bozjan Southern Front'),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Zadnor()),
                      );
                    },
                    child: const Text('Explore Zadnor'),
                  ),
                ),
              ],
            ),
          ),
          /* bottomNavigationBar: BottomNavigationBar(
            onTap: (onBotTabTapped),
            // selectedItemColor: bottomBarIndicatorColor(),
            // color = Colors.grey[600]; or color = Colors.lightBlue; or Color color = Colors.deepOrange;
            unselectedFontSize: 14,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.alternate_email),
                label: 'About',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'Donate',
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ), */
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Pages',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('How to unlock'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    scaffoldKey.currentState.openEndDrawer();
                  },
                ),
                ListTile(
                  title: Text('Bozjan Southern Front'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    scaffoldKey.currentState.openEndDrawer();
                  },
                ),
                ListTile(
                  title: Text('Zadnor'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
