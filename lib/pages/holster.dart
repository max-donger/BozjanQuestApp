import 'package:flutter/material.dart';
import '../model/holster.dart';
import '../pages/drs.dart';

var query = Uri.base.query;
var queryParam = Uri.base.queryParameters;

class HolsterListPage extends StatefulWidget {
  const HolsterListPage({super.key});

  @override
  State<HolsterListPage> createState() => _HolsterListPageState();
}

class _HolsterListPageState extends State<HolsterListPage> {
  List<String> selectedDiscord = ['LegoSteppers'];
  List<String> selectedRole = [];

  @override
  Widget build(BuildContext context) {
    final filterHolsters = holsterList.where((holster) {
      return (selectedDiscord.isEmpty ||
              selectedDiscord.contains(holster.discord)) &&
          (selectedRole.isEmpty || selectedRole.contains(holster.role));
    }).toList();
    return Scaffold(
      body: Column(
        children: [
          // Discord
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: discords
                  .map(
                    (discord) => ChoiceChip(
                      label: Text(discord),
                      selected: selectedDiscord.contains(discord),
                      onSelected: (bool selected) {
                        setState(
                          () {
                            if (selected) {
                              selectedDiscord.clear();
                              selectedDiscord.add(discord);
                            } else {
                              selectedDiscord.clear();
                            }
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          // Role
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: roles
                  .map(
                    (role) => FilterChip(
                      label: Text(role),
                      // avatar: Image.network('../assets/icon_tank.png'),
                      selected: selectedRole.contains(role),
                      onSelected: (selected) {
                        setState(
                          () {
                            if (selected) {
                              selectedRole.add(role);
                            } else {
                              selectedRole.remove(role);
                            }
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: filterHolsters.length,
                  itemBuilder: ((context, index) {
                    final holster = filterHolsters[index];
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Colors.indigoAccent),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(),
                          title: Text(
                            holster.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            holster.discord,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}

// Filter the list
// final filter = zone; // TODO: Bad, it's coming from the DRS page
final _filteredList =
    holsterList.where((holster) => holster.discord == 'LegoSteppers').toList();
// final _filteredList =
// holsters.where((holster) => holster.zone == filter).toList();
