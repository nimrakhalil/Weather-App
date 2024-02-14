import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/weather_model.dart';

import 'package:weatherapp/weather_services.dart';

void main() {
  runApp(MaterialApp(
    home: home(),
    debugShowCheckedModeBanner: false,
  ));
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final weatherService = WeatherService('cfe117fc7ef53124b539983f0579a231');
  weather? weather1;

  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        weather1 = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? weatherType) {
    switch (weatherType?.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.json';
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/windy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      default:
        // Handle cases for other weather conditions or return a default animation
        return 'assets/loading.json';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBAD9CC),
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 100,
            ),
            Icon(Icons.location_on_sharp),
            SizedBox(
              height: 10,
            ),
            Text(weather1?.cityName ?? "loading city.."),
            SizedBox(
              height: 150,
            ),
            Container(height: 200, width: 200, child: Lottie.asset(getWeatherAnimation(weather1?.mainCondition))),
            SizedBox(
              height: 200,
            ),
            Text("${weather1?.temperature.round()}°C"),
            // SizedBox(
            //   height: 10,
            // ),
            Text(weather1?.mainCondition ?? " ")
          ],
        ),
      ),
    );
  }
}
