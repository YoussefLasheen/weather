import 'package:flutter/material.dart';
import 'package:weather/components/search.dart';
import 'package:weather/models/city_model.dart';

import 'components/current_weather.dart';
import 'components/forcast_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  City selectedCity =
      City(name: 'Cairo', country: 'Egypt', lat: 51.5085, lon: -0.1257);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                City? city = await showSearch<City?>(
                  context: context,
                  delegate: CitySearchDelegate(),
                );
                if (city != null) {
                  setState(() {
                    selectedCity = city;
                  });
                }
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CurrentWeatherSection(
                  city: selectedCity,
                ),
                const SizedBox(height: 42),
                ForcastWeatherSection(
                  city: selectedCity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
