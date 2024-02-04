import 'package:BozjaHelp/model/holster.dart';
import 'package:flutter/material.dart';
import '../model/actions.dart';
import '../model/actions.dart';

class HolsterItem extends StatelessWidget {
  const HolsterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: prePopActions1.length,
            itemBuilder: (context, index) {
              return CardList(listData: prePopActions1[index]);
            },
          ),
        ),
      ]),
    );
  }
}

class CardList extends StatelessWidget {
  final List<LostAction> listData;
  late String _group;

  CardList({required this.listData});

  @override
  Widget build(BuildContext context) {
    // This code is messy, but it works.
    // It checks if the current index is the last on the list,
    // and if it is, it sets the name.
    // Because of this we also make CardList no longer immutable because of the late _group
    if (listData[0] == listData.last) {
      _group = 'Holster';
    } else {
      _group = 'PrePop when entering';
    }
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.indigoAccent),
            child: ListTile(
              title: Text('$_group'),
            ),
          ),
          Divider(),
          ListView.builder(
            itemCount: listData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(color: Colors.indigoAccent),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(listData[index].icon)),
                  title: Text(
                    listData[index].name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'some subtitle here',
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                  trailing: Text(listData[index].weight.toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
