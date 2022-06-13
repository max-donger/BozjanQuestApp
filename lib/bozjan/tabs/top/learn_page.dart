import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  LearnPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text('Learn page - Tab 1', style: TextStyle(fontSize: 24))),
    );
  }
}
