import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/models/city_model.dart';

class CurrentWeatherSection extends StatelessWidget {
  final City city;
  const CurrentWeatherSection({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Entry>(
      future: fetchWeatherByCity(city),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Entry entry = snapshot.data!;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          city.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          entry.main!.temp,
                          style: const TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Chip(
                          label:
                              FittedBox(child: Text(entry.weather.description)),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          shape: const StadiumBorder(),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.network(
                      'https://openweathermap.org/img/wn/${entry.weather.icon}@4x.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.water_drop_outlined),
                      const SizedBox(width: 10),
                      Text(entry.main!.humidity),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.cloud_outlined),
                      const SizedBox(width: 10),
                      Text(entry.clouds!),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.air),
                      const SizedBox(width: 10),
                      Text(entry.wind!),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
