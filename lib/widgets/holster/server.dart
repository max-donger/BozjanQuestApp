import 'package:flutter/material.dart';

List<String> options = ['ABBA', 'CAFE', 'Lego Steppers', 'PEBE'];

class SelectServerWidget extends StatefulWidget {
  const SelectServerWidget({super.key});

  @override
  State<SelectServerWidget> createState() => _SelectServerWidgetState();
}

class _SelectServerWidgetState extends State<SelectServerWidget> {
  String currentOption = options[2];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select your server',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text('ABBA'),
                value: options[0],
                groupValue: currentOption,
                onChanged: null,
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('CAFE'),
                value: options[1],
                groupValue: currentOption,
                onChanged: null,
              ),
            ),
            Expanded(
              child: RadioListTile(
                  title: const Text('Lego Steppers'),
                  value: options[2],
                  groupValue: currentOption,
                  onChanged: (value) {
                    setState(() {
                      currentOption = value.toString();
                    });
                  }),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('PEBE'),
                value: options[3],
                groupValue: currentOption,
                onChanged: null,
              ),
            ),
          ],
        )
      ],
    );
  }
}
