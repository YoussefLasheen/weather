class City {
  final String name;
  final String country;
  final double lat;
  final double lon;

  City(
      {required this.name,
      required this.country,
      required this.lat,
      required this.lon});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
  get fullName => '$name, $country';
}

class CityForcastData {
  final List<Day> days;
  CityForcastData({
    required this.days,
  });

  factory CityForcastData.fromJson(Map<String, dynamic> json) {
    List<Entry> days =
        List.from(json['list']).map((e) => Entry.fromJson(e)).toList();

    //Group by day
    return CityForcastData(
        days: days
            .fold<Map<DateTime, List<Entry>>>({}, (map, entry) {
              DateTime date =
                  DateTime(entry.date.year, entry.date.month, entry.date.day);
              if (map.containsKey(date)) {
                map[date]!.add(entry);
              } else {
                map[date] = [entry];
              }
              return map;
            })
            .entries
            .map((e) => Day(date: e.key, entries: e.value))
            .toList());
  }
}

class Day {
  final DateTime date;
  final List<Entry> entries;

  Day({required this.date, required this.entries});

  factory Day.fromJson(Map<String, dynamic> json) {
    List<Entry> entries =
        List.from(json['list']).map((e) => Entry.fromJson(e)).toList();
    return Day(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      entries: entries,
    );
  }
}

class Entry {
  Entry({
    required this.date,
    required this.weather,
    required this.main,
    required this.wind,
    required this.clouds,
  });
  late final DateTime date;
  late final Weather weather;
  late final Main? main;
  late final String? wind;
  late final String? clouds;

  Entry.fromJson(Map<String, dynamic> json) {
    date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    weather = Weather.fromJson(json['weather'].first);
    main = Main.fromJson(json['main']);
    wind = json['wind']['speed'].toString() + ' km/h';
    clouds = json['clouds']['all'].toString() + '%';
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  late final int? id;
  late final String? main;
  late final String description;
  late final String icon;

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });
  late final String temp;
  late final String feelsLike;
  late final String tempMin;
  late final String tempMax;
  late final String pressure;
  late final String humidity;

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toStringAsFixed(0) + '°';
    feelsLike = json['feels_like'].toString();
    tempMin = json['temp_min'].toStringAsFixed(0) + '°';
    tempMax = json['temp_max'].toStringAsFixed(0) + '°';
    pressure = json['pressure'].toString();
    humidity = json['humidity'].toString() + '%';
  }
}

// class Wind {
//   Wind({
//     required this.speed,
//     required this.deg,
//     required this.gust,
//   });
//   late final double? speed;
//   late final int? deg;
//   late final double? gust;

//   Wind.fromJson(Map<String, dynamic> json) {
//     speed = json['speed'];
//     deg = json['deg'];
//     gust = json['gust'];
//   }
// }

// class Rain {
//   Rain({
//     required this.h1,
//   });
//   late final double h1;

//   Rain.fromJson(Map<String, dynamic> json) {
//     h1 = json['1h'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['1h'] = h1;
//     return _data;
//   }
// }

// class Clouds {
//   Clouds({
//     required this.all,
//   });
//   late final int all;

//   Clouds.fromJson(Map<String, dynamic> json) {
//     all = json['all'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['all'] = all;
//     return _data;
//   }
// }
