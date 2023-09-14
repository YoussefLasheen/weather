import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/api.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/latlang.dart';

class ForcastWeatherSection extends StatelessWidget {
  final LatLng city;
  const ForcastWeatherSection({
    super.key, required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CityForcastData>(
      future: fetchForecastByCity(city),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.days.first.entries.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 32),
                    itemBuilder: (context, index) {
                      Entry day = snapshot.data!.days.first.entries[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('h a').format(day.date),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              )),
                          Image.network(
                            'https://openweathermap.org/img/wn/${day.weather.icon}@2x.png',
                            fit: BoxFit.cover,
                            height: 50,
                          ),
                          const Text(
                            '18°',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.days.length - 1,
                  itemBuilder: (context, index) {
                    Entry day = snapshot.data!.days[index + 1].entries.first;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('EEEE').format(day.date)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://openweathermap.org/img/wn/${day.weather.icon}.png',
                              fit: BoxFit.cover,
                              height: 50,
                            ),
                            Text(day.weather.description),
                            const SizedBox(width: 30),
                            Text(day.main!.tempMax),
                            const SizedBox(width: 10),
                            Text(
                              day.main!.tempMin,
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
