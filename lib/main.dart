import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// Import pages
import 'bozjan/bozjan.dart';
import 'drs/drs.dart';

import 'app.dart';
import 'providers/page_notifier.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<PageNotifier>(create: (context) => PageNotifier())
    ], child: const App());
  }
}
