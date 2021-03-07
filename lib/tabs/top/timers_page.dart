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
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Expanded(
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Stack(children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AnimatedBuilder(
                              animation: _controller,
                              builder: (BuildContext context, Widget child) {
                                return new Text(
                                  timerString,
                                  style: themeData.textTheme.headline4,
                                );
                              }),
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (BuildContext context, Widget child) {
                              return new CustomPaint(
                                painter: TimerPainter(
                                  animation: _controller,
                                  backgroundColor: themeData.backgroundColor,
                                  color: themeData
                                      .accentColor, // TODO: Is this working? It's blue instead of pink.
                                ),
                              );
                            }),
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
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
                                      ? Icons.stop
                                      : Icons.play_arrow);
                                },
                              ),
                              onPressed: () {
                                if (_controller.isAnimating) {
                                  _controller.reset();
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
class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
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

class StarMobsTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Resize the grid items https://stackoverflow.com/questions/48405123/how-to-set-custom-height-for-widget-in-gridview-in-flutter
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 1000) / 2;
    final double itemWidth = size.width / 2;

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
