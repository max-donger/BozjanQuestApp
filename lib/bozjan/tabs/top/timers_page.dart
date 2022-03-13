import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class TimersPage extends StatelessWidget {
  const TimersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CastrumTimer(),
          StarMobsTimer(),
          // WeatherTimer(),
        ],
      ),
    );
  }
}

class CastrumTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

// TODO: Do you see this AutomaticKeepAliveClientMixin and wantKeepAlive? Apply it everywhere
class _CountDownTimerState extends State<CastrumTimer>
    with AutomaticKeepAliveClientMixin<CastrumTimer>, TickerProviderStateMixin {
  // Keep this tab alive
  @override
  bool get wantKeepAlive => true;

  AnimationController _controller;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3600),
    );
  }

  // Method for increment or decrementing the timer minute hand
  void adjustTimerMinuteHand(int minutes) {
    // Prevent incrementing past 99 minutes
    if (_controller.duration + Duration(minutes: minutes) >=
        Duration(minutes: 100))
      _controller.duration = Duration(minutes: 99, seconds: 0);
    // Prevent decrementing below 0 minutes
    else if (_controller.duration + Duration(minutes: minutes) <=
        Duration(minutes: 0, seconds: 0)) {
      _controller.duration = Duration(minutes: 0, seconds: 0);
    } else {
      _controller.duration =
          _controller.duration + Duration(minutes: minutes, seconds: 0);
    }
    // Reset the animation
    _controller.reset();
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _controller.stop();
  }

// First I put it in a row, then I pad it, then I put it in Column[1], I expand the column, then I align it center. Repeat for multiple columns[2..x].
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      height:
          200, // TODO: Change the size in some other way so it fills the container better
      color: themeData.canvasColor,
      child: Row(
        children: [
          // The timer container
          Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.centerLeft,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(children: <Widget>[
                        IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: Container(
                              color: Color.fromRGBO(0, 255, 0, .5),
                            ),
                          ),
                          /*child: Icon(
                                  Icons.audiotrack,
                                  color: Color.fromRGBO(255, 0, 0, .5),
                                  size: 48.0,
                                ),),*/
                        ),
                        Positioned.fill(
                          child: AnimatedBuilder(
                              animation: _controller,
                              builder: (BuildContext context, Widget child) {
                                return new Container(
                                    child: new CustomPaint(
                                  painter: new CurtainPainter(
                                      160, 160 * _controller.value),
                                ));
                              }),
                        ),
                        // Button to increase the timer by 10 minutes
                        Positioned.fill(
                          top: 5,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: FractionalOffset.topLeft,
                              child: ElevatedButton(
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Icon(Icons.keyboard_arrow_up);
                                  },
                                ),
                                onPressed: () {
                                  adjustTimerMinuteHand(10);
                                },
                              ),
                            ),
                          ),
                        ),
                        // Button to increase the timer by 1 minute
                        Positioned.fill(
                          top: 5,
                          left: 60,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: FractionalOffset.topLeft,
                              child: ElevatedButton(
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Icon(Icons.keyboard_arrow_up);
                                  },
                                ),
                                onPressed: () {
                                  adjustTimerMinuteHand(1);
                                },
                              ),
                            ),
                          ),
                        ),
                        // Button to decrease the timer by 10 minutes
                        Positioned.fill(
                          bottom: 5,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: FractionalOffset.bottomLeft,
                              child: ElevatedButton(
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Icon(Icons.keyboard_arrow_down);
                                  },
                                ),
                                onPressed: () {
                                  adjustTimerMinuteHand(-10);
                                },
                              ),
                            ),
                          ),
                        ),
                        // Button to decrease the timer by 1 minute
                        Positioned.fill(
                          bottom: 5,
                          left: 60,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: Align(
                              alignment: FractionalOffset.bottomLeft,
                              child: ElevatedButton(
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Icon(Icons.keyboard_arrow_down);
                                  },
                                ),
                                onPressed: () {
                                  adjustTimerMinuteHand(-1);
                                },
                              ),
                            ),
                          ),
                        ),
                        // The time (MM:ss)
                        IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: AnimatedBuilder(
                                animation: _controller,
                                builder: (BuildContext context, Widget child) {
                                  return new Text(
                                    timerString,
                                    style: themeData.textTheme.headline3,
                                  );
                                }),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          // The start/stop button
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: 'CastrumStartStop',
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (BuildContext context, Widget child) {
                                  return new Icon(_controller.isAnimating
                                      ? Icons.pause
                                      : Icons.play_arrow);
                                },
                              ),
                              onPressed: () {
                                if (_controller.isAnimating) {
                                  _controller.stop();
                                } else {
                                  _controller.reverse(
                                      from: _controller.value == 0.0
                                          ? 1.0
                                          : _controller.value);
                                }
                              },
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // The description
          Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Text(
                    'Castrum Lacus Litore',
                    // style: themeData.textTheme.subtitle1,
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: IconButton(
                    icon: const Icon(Icons.help),
                    iconSize: 36,
                    color: Colors.grey,
                    tooltip:
                        'Castrum timer is 60 minutes from start of the instance or the last raid, with reduced time for each Fate/CE cleared. Average is 30 minutes on a full instance.',
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// TODO: add themeData here
class CurtainPainter extends CustomPainter {
  final double _width;
  double _rectHeight;

  CurtainPainter(this._width, this._rectHeight);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      new Rect.fromLTRB(
          0.0, size.height - _rectHeight, this._width, size.height),
      new Paint()..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(CurtainPainter oldDelegate) {
    return _width != oldDelegate._width ||
        _rectHeight != oldDelegate._rectHeight;
  }
}

class WeatherTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'WeatherTimer',
            icon: const Icon(Icons.add),
            label: Text('Add timer'),
            onPressed: () {},
          ),
        ],
      ),
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
  AnimationController _controller3L;

  String get timer3L {
    Duration duration = _controller3L.duration * _controller3L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller3M;

  String get timer3M {
    Duration duration = _controller3M.duration * _controller3M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller3R;

  String get timer3R {
    Duration duration = _controller3R.duration * _controller3R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller2L;

  String get timer2L {
    Duration duration = _controller2L.duration * _controller2L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller2M;

  String get timer2M {
    Duration duration = _controller2M.duration * _controller2M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller2R;

  String get timer2R {
    Duration duration = _controller2R.duration * _controller2R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller1L;

  String get timer1L {
    Duration duration = _controller1L.duration * _controller1L.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller1M;

  String get timer1M {
    Duration duration = _controller1M.duration * _controller1M.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  AnimationController _controller1R;

  String get timer1R {
    Duration duration = _controller1R.duration * _controller1R.value;
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  // initState
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var overlayImages = <OverlayImage>[
      OverlayImage(
          bounds: LatLngBounds(latLng.LatLng(-1, -1.5), latLng.LatLng(1, 1)),
          imageProvider: NetworkImage('lib/bozjan/img/bozjan.jpeg')),
    ];
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        height: MediaQuery.of(context).size.height - 400,
        width: MediaQuery.of(context).size.width,
        color: themeData.canvasColor,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: FlutterMap(
            options: MapOptions(
              crs: CrsSimple(),
              center: latLng.LatLng(0, 0),
              bounds: LatLngBounds(latLng.LatLng(-1, -1), latLng.LatLng(1, 1)),
              swPanBoundary: latLng.LatLng(-0.75, -0.75),
              nePanBoundary: latLng.LatLng(0.75, 0.75),
            ),
            layers: [
              OverlayImageLayerOptions(overlayImages: overlayImages),
              MarkerLayerOptions(
                markers: [
                  // Z2 Cyclops
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: latLng.LatLng(0.10, 0.21),
                    builder: (ctx) => Container(
                      child: Image(
                        image: NetworkImage('lib/bozjan/img/icon_star-mob.png'),
                      ),
                    ),
                  ),
                  // Z2 Lion
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: latLng.LatLng(0.18, 0.49),
                    builder: (ctx) => Container(
                      child: Image(
                        image: NetworkImage('lib/bozjan/img/icon_star-mob.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
