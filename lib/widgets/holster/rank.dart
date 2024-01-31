import 'package:flutter/material.dart';

class SelectRankWidget extends StatefulWidget {
  const SelectRankWidget({super.key});

  @override
  State<SelectRankWidget> createState() => _SelectRankWidgetState();
}

class _SelectRankWidgetState extends State<SelectRankWidget> {
  double _currentSliderValue = 25;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        'What Resistance Rank are you?',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
      Slider(
          value: _currentSliderValue,
          min: 15,
          max: 25,
          divisions: 10,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          }),
      Text(
        '$_currentSliderValue',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    ]);
  }
}
