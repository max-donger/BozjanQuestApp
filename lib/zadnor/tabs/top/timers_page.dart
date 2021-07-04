import 'package:flutter/material.dart';
import 'dart:math' as math;

class TimersPage extends StatelessWidget {
  const TimersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DaldriadaTimer(),
          StarMobsTimer(),
          // WeatherTimer(),
        ],
      ),
    );
  }
}

class DaldriadaTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

// TODO: Do you see this AutomaticKeepAliveClientMixin and wantKeepAlive? Apply it everywhere
class _CountDownTimerState extends State<DaldriadaTimer>
    with
        AutomaticKeepAliveClientMixin<DaldriadaTimer>,
        TickerProviderStateMixin {
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
                              heroTag: 'DaldriadaStartStop',
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
                    'Daldriada',
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
                        'Daldriada timer is 60 minutes from start of the instance or the last raid, with reduced time for each Fate/CE cleared. Average is 30 minutes on a full instance.',
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
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        height: MediaQuery.of(context).size.height - 400,
        color: themeData.canvasColor,
        child:
            // The timer container
            Padding(
          padding: EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              // Background image
              IgnorePointer(
                  ignoring: true,
                  child: Image.asset('lib/zadnor/img/zadnor.jpeg')),
              // 3L Glyptodon Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.47, -0.36),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob3L',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Glyptodon',
                      child: AnimatedBuilder(
                        animation: _controller3L,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller3L.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller3L.isAnimating) {
                          _controller3L.stop();
                        } else {
                          _controller3L.reverse(
                              from: _controller3L.value == 0.0
                                  ? 1.0
                                  : _controller3L.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 3L Glyptodon Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.47, -0.36),
                    child: AnimatedBuilder(
                      animation: _controller3L,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer3L,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 3M Molten Scorpion Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.08, -0.22),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob3M',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Molten Scorpion',
                      child: AnimatedBuilder(
                        animation: _controller3M,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller3M.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller3M.isAnimating) {
                          _controller3M.stop();
                        } else {
                          _controller3M.reverse(
                              from: _controller3M.value == 0.0
                                  ? 1.0
                                  : _controller3M.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 3M Molten Scorpion Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.08, -0.22),
                    child: AnimatedBuilder(
                      animation: _controller3M,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer3M,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 3R Vapula Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.06, -0.56),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob3R',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Vapula',
                      child: AnimatedBuilder(
                        animation: _controller3R,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller3R.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller3R.isAnimating) {
                          _controller3R.stop();
                        } else {
                          _controller3R.reverse(
                              from: _controller3R.value == 0.0
                                  ? 1.0
                                  : _controller3R.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 3R Vapula Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.06, -0.56),
                    child: AnimatedBuilder(
                      animation: _controller3R,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer3R,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 2L Lord Ochu Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.82, -0.13),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob2L',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Lord Ochu',
                      child: AnimatedBuilder(
                        animation: _controller2L,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller2L.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller2L.isAnimating) {
                          _controller2L.stop();
                        } else {
                          _controller2L.reverse(
                              from: _controller2L.value == 0.0
                                  ? 1.0
                                  : _controller2L.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 2L Lord Ochu Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.82, -0.13),
                    child: AnimatedBuilder(
                      animation: _controller2L,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer2L,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 2M Aglaophotis Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.63, 0.35),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob2M',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Aglaophotis',
                      child: AnimatedBuilder(
                        animation: _controller2M,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller2M.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller2M.isAnimating) {
                          _controller2M.stop();
                        } else {
                          _controller2M.reverse(
                              from: _controller2M.value == 0.0
                                  ? 1.0
                                  : _controller2M.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 2M Aglaophotis Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.63, 0.35),
                    child: AnimatedBuilder(
                      animation: _controller2M,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer2M,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 2R Earth Eater Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.44, 0.48),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob2R',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Earth Eater',
                      child: AnimatedBuilder(
                        animation: _controller2R,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller2R.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller2R.isAnimating) {
                          _controller2R.stop();
                        } else {
                          _controller2R.reverse(
                              from: _controller2R.value == 0.0
                                  ? 1.0
                                  : _controller2R.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 2R Earth Eater Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.44, 0.48),
                    child: AnimatedBuilder(
                      animation: _controller2R,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer2R,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 1L Stratogryph Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(-0.23, 0.75),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob1L',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Stratogryph',
                      child: AnimatedBuilder(
                        animation: _controller1L,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller1L.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller1L.isAnimating) {
                          _controller1L.stop();
                        } else {
                          _controller1L.reverse(
                              from: _controller1L.value == 0.0
                                  ? 1.0
                                  : _controller1L.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 1L Stratogryph Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(-0.23, 0.75),
                    child: AnimatedBuilder(
                      animation: _controller1L,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer1L,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 1M Anancus Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0.16, 0.30),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob1M',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Anancus',
                      child: AnimatedBuilder(
                        animation: _controller1M,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller1M.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller1M.isAnimating) {
                          _controller1M.stop();
                        } else {
                          _controller1M.reverse(
                              from: _controller1M.value == 0.0
                                  ? 1.0
                                  : _controller1M.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 1M Anancus Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(0.24, 0.22),
                    child: AnimatedBuilder(
                      animation: _controller1M,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer1M,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // 1R Vinegaroon Executioner Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment(0.53, 0.38),
                  child: Material(
                    color: Colors.transparent,
                    child: FloatingActionButton(
                      heroTag: 'StarMob1R',
                      backgroundColor: Colors.transparent,
                      tooltip: 'Vinegaroon Executioner',
                      child: AnimatedBuilder(
                        animation: _controller1R,
                        builder: (BuildContext context, Widget child) {
                          return new Icon(_controller1R.isAnimating
                              ? Icons.star_border
                              : Icons.star);
                        },
                      ),
                      onPressed: () {
                        if (_controller1R.isAnimating) {
                          _controller1R.stop();
                        } else {
                          _controller1R.reverse(
                              from: _controller1R.value == 0.0
                                  ? 1.0
                                  : _controller1R.value);
                        }
                      },
                    ),
                  ),
                ),
              ),
              // 1R Vinegaroon Executioner Text
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Align(
                    alignment: Alignment(0.69, 0.34),
                    child: AnimatedBuilder(
                      animation: _controller1R,
                      builder: (BuildContext context, Widget child) {
                        return new Text(
                          timer1R,
                          style: themeData.textTheme.headline4,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
