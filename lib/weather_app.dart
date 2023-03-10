import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
   String _location = 'San Francisco';
  String _weatherCondition = '';
  double _temperature = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final apiKey = 'your_api_key_here';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_location&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _weatherCondition = data['weather'][0]['main'];
        _temperature = data['main']['temp'];
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$_weatherCondition.svg',
              height: 100,
            ),
            SizedBox(height: 16),
            Text(
              '$_temperature °C',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 16),
            Text(
              '$_location',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

