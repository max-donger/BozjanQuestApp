import 'package:flutter/material.dart';
import '../pages/drs.dart';

var query = Uri.base.query;
var queryParam = Uri.base.queryParameters;

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
        children: List.generate(_filteredList.length, (index) {
          return Center(
            child: SelectCard(holster: _filteredList[index]),
          );
          /* List.generate(10, (index) {
            return Center(
              child: Text(
                'Loadout $query',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }), */
        }),
      ),
    ));
  }
}

// TODO: Move this to a widget?
class Holster {
  const Holster(
      {this.title = 'ERR:Failed to load',
      this.icon = Icons.error,
      this.zone = '',
      this.rank = 0});
  final String title;
  final IconData? icon;
  final String zone;
  final double rank;
}

// Filter the list
// final filter = zone; // TODO: Bad, it's coming from the DRS page
final _filteredList =
    holsters.where((holster) => holster.rank == rank).toList();
// final _filteredList =
// holsters.where((holster) => holster.zone == filter).toList();

// The list of all Holsters
const List<Holster> holsters = const <Holster>[
  const Holster(title: 'DRS-1', icon: Icons.home, zone: 'drs', rank: 15),
  const Holster(title: 'DRS-2', icon: Icons.contacts, zone: 'drs', rank: 20),
  const Holster(title: 'DRS-3', icon: Icons.map, zone: 'drs', rank: 25),
  const Holster(title: 'BSF-1', icon: Icons.phone, zone: 'bsf', rank: 25),
  const Holster(title: 'BSF-2', icon: Icons.camera_alt, zone: 'bsf', rank: 25),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.holster}) : super(key: key);
  final Holster holster;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.lightGreenAccent,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(
                  holster.icon, size: 50.0, // color: textStyle.color
                )),
                Text(
                  holster.title, // style: textStyle
                ),
              ]),
        ));
  }
}
