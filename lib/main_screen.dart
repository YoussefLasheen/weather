import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/api.dart';
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
  late Future<List> futureData;

  @override
  void initState() {
    selectedCity = widget.city;

    futureData = Future.wait(
      [
        fetchWeatherByCity(selectedCity!),
        fetchForecastByCity(selectedCity!),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
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
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureData = Future.wait(
                [
                  fetchWeatherByCity(selectedCity!),
                  fetchForecastByCity(selectedCity!),
                ],
              );
            });
          },
          child: FutureBuilder<List>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Entry entry = snapshot.data!.first;
                CityForcastData cityForcastData = snapshot.data!.last;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        CurrentWeatherSection(
                          entry: entry,
                        ),
                        const SizedBox(height: 42),
                        ForcastWeatherSection(
                          cityForcastData: cityForcastData,
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
