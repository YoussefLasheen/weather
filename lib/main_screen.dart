import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/components/search.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/latlang.dart';

import 'components/current_weather.dart';
import 'components/forcast_weather.dart';

class MainScreen extends StatefulWidget {
  final LatLng city;
  const MainScreen({super.key, required this.city});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LatLng? selectedCity;

  @override
  void initState() {
    selectedCity = widget.city;
    super.initState();
  }

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
                    selectedCity = LatLng(
                      latitude: city.lat,
                      longitude: city.lon,
                    );
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
                  city: selectedCity!,
                ),
                const SizedBox(height: 42),
                ForcastWeatherSection(
                  city: selectedCity!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
