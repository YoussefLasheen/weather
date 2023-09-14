import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/main_screen.dart';
import 'package:weather/models/latlang.dart';

import 'components/search.dart';
import 'models/city_model.dart';
import 'services/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: GoogleFonts.latoTextTheme().apply(
          bodyColor: const Color(0xFF28355d),
        ),
      ),
      home: FutureBuilder<LatLng>(
        future: determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen(city: snapshot.data!);
          }

          if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const SelectCityScreen();
          }
          return const Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Initialising...'),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We could not determine your location. \nPlease select a city.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                City? city = await showSearch<City?>(
                  context: context,
                  delegate: CitySearchDelegate(),
                );
                if (city != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        city: LatLng(
                          latitude: city.lat,
                          longitude: city.lon,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: const Text('Select City'),
            )
          ],
        ),
      ),
    );
  }
}
