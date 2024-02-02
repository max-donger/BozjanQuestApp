import 'package:flutter/material.dart';

double? _rank = 0;

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
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value;
            });
            _rank = _currentSliderValue;
            print('I changed to rank $_rank');
          }),
      Text(
        '$_currentSliderValue',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
      ),
    ]);
  }
}

getRank() {
  return _rank;
}
