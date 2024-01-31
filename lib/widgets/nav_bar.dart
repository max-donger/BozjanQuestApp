import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

/*
// Import top tabs
import '../drs/tabs/top/learn_page.dart';
import '../drs/tabs/top/bosses_page.dart';
import '../drs/tabs/top/duel_page.dart';
import '../drs/tabs/top/holster_page.dart';

// Import bottom tabs
import '../drs/tabs/bottom/about_page.dart';
import '../drs/tabs/bottom/settings_page.dart';
*/

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<PageNotifier>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: const EdgeInsets.only(right: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MenuItem(
            page: PageName.home,
            onTap: () {
              if (notifier.pageName != PageName.home) {
                notifier.changePage(page: PageName.home, unknown: false);
              }
            },
          ),
          const SizedBox(width: 20.0),
          MenuItem(
            page: PageName.drs,
            onTap: () {
              if (notifier.pageName != PageName.drs) {
                notifier.changePage(page: PageName.drs, unknown: false);
              }
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final PageName page;
  final VoidCallback onTap;
  const MenuItem({required this.page, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(page.name, style: const TextStyle(fontSize: 18.0)),
    );
  }
}
