import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
// import 'custom_popup.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'map_popup.dart';
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
              popupBuilder: (BuildContext context, Marker marker) => MapPopup(
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
          width: 110,
          height: 40,
          builder: (_) => Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Tweak this for positioning
            crossAxisAlignment:
                CrossAxisAlignment.center, // Tweak this for positioning
            children: [
              Image.asset(
                'lib/bozjan/img/icon_exclamation-point.png',
                width: 49,
                height: 65,
              ),
              Expanded(
                child: MapPopupTimer(),
              ),
            ],
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
