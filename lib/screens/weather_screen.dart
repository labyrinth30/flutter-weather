import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openweathermap/models/weather_model.dart';
import 'package:openweathermap/secrets/secret.dart';
import 'package:openweathermap/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // api key
  final _weatherService = WeatherService(apiKey: secret.apiKey);
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // 현재 도시 얻기
    String cityName = await _weatherService.getCurrentCity();
    // 날씨 정보 가져오기

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animaitons
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'frog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // initState
  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city...'),

            //animation
            Lottie.asset(
              getWeatherAnimation(_weather?.mainCondition),
            ),

            // temperature
            Text('${_weather?.temperature.round()} °C'),
            // weather condition

            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
