import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city...'),
            // temperature
            Text('${_weather?.temperature.round()} °C'),
          ],
        ),
      ),
    );
  }
}
