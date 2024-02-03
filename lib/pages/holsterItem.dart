import 'package:flutter/material.dart';

class HolsterItem extends StatelessWidget {
  const HolsterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Change DefaultTabController to just Scaffold?
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          Expanded(
            child: ListView(
              children: List.generate(5, (index) {
                return Center(
                  child: Text(
                    'Lost Action $index',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
