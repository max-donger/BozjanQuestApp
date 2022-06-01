import 'package:flutter/material.dart';
import '../../utils/ForecastWeather.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WeatherTimer(),
        ],
      ),
    );
  }
}

class WeatherTimer extends StatefulWidget {
  @override
  _WeatherTimerState createState() => _WeatherTimerState();
}

class _WeatherTimerState extends State<WeatherTimer>
    with AutomaticKeepAliveClientMixin<WeatherTimer>, TickerProviderStateMixin {
  // Keep this tab alive
  @override
  bool get wantKeepAlive => true;

  late AnimationController _controller;

  String get weatherString {
    Duration duration = _controller.duration! * _controller.value;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int weatherString = forecastWeather(currentTime);
    return 'Weather chance now: ${weatherString.toString()} , DateTimeUnix now: ${(currentTime).toString()}';
  }

  // TODO: STILL DO THIS
  String get weatherStringNext {
    Duration duration = _controller.duration! * _controller.value;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int weatherStringNext = forecastWeather(currentTime);
    return 'Weather chance now: ${weatherStringNext.toString()} , DateTimeUnix now: ${(currentTime).toString()}';
  }

  /*
  https://github.com/eorzea-weather/eorzea-weather/blob/master/src/chances.ts

export const bozjanSouthernFront = (chance: number): string => {
  if (chance < 52) {
    return WEATHER_FAIR_SKIES;
  }
  if (chance < 64) {
    return WEATHER_RAIN;
  }
  if (chance < 76) {
    return WEATHER_WIND;
  }
  if (chance < 88) {
    return WEATHER_THUNDER;
  }
  return WEATHER_DUST_STORMS;
};

  See also prediction https://github.com/eorzea-weather/eorzea-weather-app/blob/master/src/pages/api/zones/%5Bid%5D/forecast.ts
*/

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200.0,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: Colors.amber[600],
              child: Center(
                child: Text(
                  weatherString,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.amber[500],
              child: Center(
                child: Text(
                  weatherStringNext,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(child: Text('Entry C')),
            ),
          ],
        ),
      ),
    );
  }
}
