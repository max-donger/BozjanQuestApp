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

  CardList({required this.listData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('List ${listData[0]}'),
          ),
          Divider(),
          ListView.builder(
            itemCount: listData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listData[index].name),
              );
            },
          ),
        ],
      ),
    );
  }
}
