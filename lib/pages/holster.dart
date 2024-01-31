import 'package:flutter/material.dart';

class HolsterPage extends StatelessWidget {
  const HolsterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.count(
          // Columns
          crossAxisCount: 3,
          // Generate 10 widgets that display their index in the List.
          children: List.generate(10, (index) {
            return Center(
              child: Text(
                'Loadout $index',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }),
        ),
      ),
    );
  }
}
