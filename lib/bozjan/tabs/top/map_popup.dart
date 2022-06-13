import 'package:bozjan_quest_app/bozjan/tabs/top/map_page.dart';
import 'package:bozjan_quest_app/zadnor/tabs/top/timers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPopup extends StatefulWidget {
  final Marker marker;

  MapPopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPopupState(marker);
}

class _MapPopupState extends State<MapPopup>
    with AutomaticKeepAliveClientMixin<MapPopup>, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  final Marker _marker;
  final MarkerData _markerData = new MarkerData();

  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;

  _MapPopupState(this._marker);

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
      markerReward = '9-20 Forgotten Fragments of Ingenuity';
    } else if (trimmedMarkerKey == 'Z2-3') {
      markerReward = '9-20 Forgotten Fragments of Ingenuity';
    } else {
      markerReward = 'Unable to resolve ' + markerKey.toString();
    }
    return markerReward;
  }
}

// MapPopupTimer
class MapPopupTimer extends StatefulWidget {
  MapPopupTimer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPopupTimerState();
}

class _MapPopupTimerState extends State<MapPopupTimer>
    with
        AutomaticKeepAliveClientMixin<MapPopupTimer>,
        TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late AnimationController _controller;

  String get timer2M {
    Duration duration = _controller.duration! * _controller.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: FloatingActionButton(
        heroTag: 'StarMob',
        backgroundColor: Colors.transparent,
        hoverColor: Colors.white,
        shape: RoundedRectangleBorder(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return new Text(
              timer2M,
              style: themeData.textTheme.headline6,
            );
          },
        ),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.reverse(
                from: _controller.value == 0.0 ? 1.0 : _controller.value);
          }
        },
      ),
    );
  }
}
