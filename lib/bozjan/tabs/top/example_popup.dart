import 'package:bozjan_quest_app/bozjan/tabs/top/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ExamplePopup extends StatefulWidget {
  final Marker marker;

  ExamplePopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState(marker);
}

class _ExamplePopupState extends State<ExamplePopup> {
  final Marker _marker;
  final MarkerData _markerData = new MarkerData();

  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;

  _ExamplePopupState(this._marker);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(_icons[_currentIcon]),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _markerData.getMarkerText(_marker.key),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Some text here',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              _markerData.getMarkerReward(_marker.key),
              style: const TextStyle(fontSize: 12.0),
            ),
            /*
            Text(
              'Position: ${_marker.point.latitude}, ${_marker.point.longitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Marker size: ${_marker.width}, ${_marker.height}',
              style: const TextStyle(fontSize: 12.0),
            ),
            */
          ],
        ),
      ),
    );
  }
}

// Can do some refactoring here
class MarkerData {
  getMarkerText(markerKey) {
    var markerNameplate = 'null';
    var trimmedMarkerKey =
        markerKey.toString().substring(4, markerKey.toString().length - 4);
    if (trimmedMarkerKey == 'Random FATE') {
      markerNameplate = 'a random fate';
    } else if (trimmedMarkerKey == 'Z2-2') {
      markerNameplate = 'Viy';
    } else if (trimmedMarkerKey == 'Z2-3') {
      markerNameplate = 'Psoglav';
    } else {
      markerNameplate = 'Unable to resolve ' + trimmedMarkerKey.toString();
    }
    return markerNameplate;
  }

  getMarkerReward(markerKey) {
    var markerReward = 'null';
    var trimmedMarkerKey =
        markerKey.toString().substring(4, markerKey.toString().length - 4);
    if (trimmedMarkerKey == 'Random FATE') {
      markerReward = 'A lootbox';
    } else if (trimmedMarkerKey == 'Z2-2') {
      markerReward = '0-19 Forgotten Fragments of Ingenuity';
    } else if (trimmedMarkerKey == 'Z2-3') {
      markerReward = '0-19 Forgotten Fragments of Ingenuity';
    } else {
      markerReward = 'Unable to resolve ' + markerKey.toString();
    }
    return markerReward;
  }
}
