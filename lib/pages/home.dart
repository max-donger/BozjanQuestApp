import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

// Import pages
import '../bozjan/bozjan.dart';
import '../drs/drs.dart';

import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
                    if (notifier.pageName != PageName.drs) {
                      notifier.changePage(page: PageName.drs, unknown: false);
                    }
                  },
                  child: const Text('Delubrum Reginae (Savage)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
