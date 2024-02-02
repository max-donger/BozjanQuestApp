import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums.dart';
import '../providers/page_notifier.dart';

import '../widgets/holster/server.dart';
import '../widgets/holster/rank.dart';

final _formKey = GlobalKey<FormState>();

// TODO: Bad. This needs to be improved
String drsQuery = '';
String zone = '';
double _rank = getRank();
double rank = _rank;

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Server
                SelectServerWidget(),
                // Class
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                ),
                // Rank
                FormField<int>(
                  builder: (state) {
                    return SelectRankWidget();
                  },
                ),
                // Job
                // ShowLoadouts
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Here are your loadouts!')));
                      if (notifier.pageName != PageName.holster) {
                        drsQuery = 'zone=drs';
                        zone = 'drs';
                        // save the form fields
                        _formKey.currentState?.save();
                        print(_rank);
                        notifier.changePage(
                            page: PageName.holster,
                            unknown: false,
                            query: drsQuery);
                      }
                    }
                  },
                  child: const Text('Show Loadouts - DRS'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Here are your loadouts!')));
                      if (notifier.pageName != PageName.holster) {
                        drsQuery = 'zone=bsf';
                        zone = 'bsf';
                        notifier.changePage(
                            page: PageName.holster,
                            unknown: false,
                            query: drsQuery);
                      }
                    }
                  },
                  child: const Text('Show Loadouts - BSF'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
