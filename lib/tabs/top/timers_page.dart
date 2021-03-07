import 'package:flutter/material.dart';
import 'dart:math' as math;

class TimersPage extends StatelessWidget {
  const TimersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [CastrumTimer(), WeatherTimer(), StarMobsTimer()],
      ),
    );
  }
}

class CastrumTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CastrumTimer>
    with TickerProviderStateMixin {
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
                          child: Positioned.fill(
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
                          child: Positioned.fill(
                            child: Align(
                              alignment: FractionalOffset.center,
                              child: AnimatedBuilder(
                                  animation: _controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return new Text(
                                      timerString,
                                      style: themeData.textTheme.headline3,
                                    );
                                  }),
                            ),
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
          )
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

/*
class _StarMobsTimerState extends State<StarMobsTimer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Resize the grid items https://stackoverflow.com/questions/48405123/how-to-set-custom-height-for-widget-in-gridview-in-flutter
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 1000) / 2;
    final double itemWidth = size.width / 2;
*/
class _StarMobsTimerState extends State<StarMobsTimer>
    with TickerProviderStateMixin {
  double _size = 50.0;
  double targetValue = 24.0;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 250.0 : 100.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => _updateSize(),
          child: AnimatedContainer(
            height: _size,
            color: Colors.amberAccent,
            duration: Duration(seconds: 1),
          ),
        ),
      ],
    );
  }
}

/*
    return Center(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: (itemWidth / itemHeight),
        children: <Widget>[
          Ink(
            decoration: BoxDecoration(
              color: Colors.teal[100],
            ),
            child: InkWell(
              onTap: () {},
              child: const Text("Patty"),
              splashColor: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Clingy Clare'),
            color: Colors.teal[200],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Bird of Barathrum'),
            color: Colors.teal[300],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Smok'),
            color: Colors.teal[400],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Viy'),
            color: Colors.teal[500],
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Psoglav'),
              color: Colors.teal[600]),
          Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Tideborn Angel'),
              color: Colors.red[600]),
          Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Fern Flower'),
              color: Colors.teal[600]),
          Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Ink Claw'),
              color: Colors.teal[600]),
        ],
      ),
    );
  }
}
*/

/*
class AddTimer extends class PattyTimer extends StatefulWidget {
  PattyTimer({Key key}) : super(key: key);

  @override
  _PattyTimerState createState() => _PattyTimerState();
}

class _PattyTimerState extends State<PattyTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}
*/
