import 'package:flutter/material.dart';

import 'components/current_weather.dart';
import 'components/forcast_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36),
                CurrentWeatherSection(),
                SizedBox(height: 42),
                ForcastWeatherSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
