import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mentals_health_app/models/weather_model.dart';
import 'package:mentals_health_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // apikey
  final _weatherService = WeatherServices('43e0bb25b43fa351a25a60bd99d47bfa');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the currect city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animation 
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null ) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke' :
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain' :
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';


    }

  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // city Name
          Text(_weather?.cityName ?? 'Loading...'),
    
          // animations
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),


          // temp
          Text('${_weather?.temp.round()}°C'),

          // weather condition
          Text(_weather?.mainCondition ?? "")


        ],),
      ),
    );
  }
}
