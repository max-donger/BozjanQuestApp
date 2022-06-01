import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'custom_popup.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'example_popup.dart';
// import 'package:flutter_map_marker_popup_example/font/accurate_map_icons.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StarMobsTimer(),
    );
  }
}

class StarMobsTimer extends StatefulWidget {
  @override
  _StarMobsTimerState createState() => _StarMobsTimerState();
}

class _StarMobsTimerState extends State<StarMobsTimer>
    with
        AutomaticKeepAliveClientMixin<StarMobsTimer>,
        TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  // TODO: Put this in lists
  late AnimationController _controller3L;

  String get timer3L {
    Duration duration = _controller3L.duration! * _controller3L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller3M;

  String get timer3M {
    Duration duration = _controller3M.duration! * _controller3M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller3R;

  String get timer3R {
    Duration duration = _controller3R.duration! * _controller3R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller2L;

  String get timer2L {
    Duration duration = _controller2L.duration! * _controller2L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller2M;

  String get timer2M {
    Duration duration = _controller2M.duration! * _controller2M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller2R;

  String get timer2R {
    Duration duration = _controller2R.duration! * _controller2R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller1L;

  String get timer1L {
    Duration duration = _controller1L.duration! * _controller1L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller1M;

  String get timer1M {
    Duration duration = _controller1M.duration! * _controller1M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  late AnimationController _controller1R;

  String get timer1R {
    Duration duration = _controller1R.duration! * _controller1R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

/*
  // initState
  @override
  void initState() {
    super.initState();
    _markers = _buildMarkersOnMap();
    _controller3L = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller3M = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller3R = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller2L = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller2M = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller2R = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller1L = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller1M = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
    _controller1R = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1800),
    );
  }
  */

  final List<latLng.LatLng> _markerPositions = [
    latLng.LatLng(0.25, 0.42), // Random FATE
    latLng.LatLng(0.09, 0.21), // Z2 Cyclops
    latLng.LatLng(0.18, 0.49), // Z2 Lion
  ];

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

/*
  List<Marker> _buildMarkersOnMap() {
    return [
      // Random FATE
      Marker(
        width: 40.0,
        height: 40.0,
        point: latLng.LatLng(0.25, 0.42),
        builder: (context) => GestureDetector(
          onTap: () {
            setState(() {
              infoWindowVisible = !infoWindowVisible;
            });
          },
          child: _buildCustomMarker(),
        ),
      ),
      // Z2 Cyclops
      Marker(
        point: latLng.LatLng(0.10, 0.21),
        width: 40.0,
        height: 40.0,
        builder: (context) => Container(
          child: Image(
            image: NetworkImage('lib/bozjan/img/icon_star-mob.png'),
          ),
        ),
      ),
      // Z2 Lion
      Marker(
        point: latLng.LatLng(0.18, 0.49),
        width: 40.0,
        height: 40.0,
        builder: (context) => Container(
          child: Image(
            image: NetworkImage('lib/bozjan/img/icon_star-mob.png'),
          ),
        ),
      ),
    ];
  }
  */

/*
  Opacity marker() {
    super.build(context);
    return Opacity(
      child: Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'lib/bozjan/img/icon_exclamation-point.png',
            width: 49,
            height: 65,
          )),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }
*/

  // Build the Map
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData themeData = Theme.of(context);
    var overlayImages = <OverlayImage>[
      OverlayImage(
          bounds: LatLngBounds(latLng.LatLng(-1, -1.5), latLng.LatLng(1, 1)),
          imageProvider: NetworkImage('lib/bozjan/img/bozjan.jpeg')),
    ];
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: themeData.canvasColor,
      child: FlutterMap(
        options: MapOptions(
          crs: CrsSimple(),
          center: latLng.LatLng(0, 0),
          bounds: LatLngBounds(latLng.LatLng(-1, -1), latLng.LatLng(1, 1)),
          minZoom:
              1, // Ensures the map text stays crisp, but prevents zooming out further
          maxZoom: 2.5,
          swPanBoundary: latLng.LatLng(-0.75, -0.75),
          nePanBoundary: latLng.LatLng(0.75, 0.75),
          onTap: (_, __) => _popupLayerController
              .hideAllPopups(), // Hide popup when the map is tapped.
        ),
        children: [
          OverlayImageLayerWidget(
            options: OverlayImageLayerOptions(overlayImages: overlayImages),
          ),
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              popupController: _popupLayerController,
              markers: _markers,
              markerRotateAlignment:
                  PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
              popupBuilder: (BuildContext context, Marker marker) =>
                  ExamplePopup(
                marker,
              ),
            ),
          ),
        ],
      ),
    );
  }

// Build the Markers
  List<Marker> get _markers => _markerPositions
      .map(
        (markerPosition) => Marker(
          //           key: Key(_markerPositions.indexOf(markerPosition).toString()),
          key: Key(_markerText
              .where((markertext) =>
                  _markerText.indexOf(markertext) ==
                  _markerPositions.indexOf(markerPosition))
              .toString()),
          point: markerPosition,
          width: 40,
          height: 40,
          builder: (_) => Image.asset(
            'lib/bozjan/img/icon_exclamation-point.png',
            width: 49,
            height: 65,
          ),
          anchorPos: AnchorPos.align(AnchorAlign.top),
        ),
      )
      .toList();

  final List<String> _markerText = [
    'Random FATE', // Random FATE
    'Z2-2', // Z2 Cyclops
    'Z2-3', // Z2 Lion
  ];
}
