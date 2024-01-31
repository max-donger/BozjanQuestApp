import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

// Import pages
import '../bozjan/bozjan.dart';
import '../drs/drs.dart';

import '../widgets/nav_bar.dart';
import '../widgets/holster/server.dart';
import '../widgets/holster/rank.dart';

class DrsPage extends StatelessWidget {
  const DrsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    // TODO: Change DefaultTabController to just Scaffold?
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Server
              SelectServerWidget(),
              // Class
              // Rank
              SelectRankWidget(),
              // Job
              // ShowLoadouts
              ElevatedButton(
                onPressed: () {
                  if (notifier.pageName != PageName.holster) {
                    notifier.changePage(page: PageName.holster, unknown: false);
                  }
                },
                child: const Text('Show Loadouts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
