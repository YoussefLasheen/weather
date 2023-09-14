import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';
import 'models/city_model.dart';

Future<CityForcastData> fetchForecastByCity(City city) async {
  Map<String, String> params = {
    'lat': city.lat.toString(),
    'lon': city.lon.toString(),
    'appid': ApiConstants.apiKey,
    'units': 'metric'
  };

  var url =
      Uri.http(ApiConstants.baseUrl, ApiConstants.getWeatherForcast, params);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    CityForcastData model = CityForcastData.fromJson(jsonDecode(response.body));
    return model;
  } else {
    throw Exception(
        'Failed to load city weather forecast for id: ${city.name}');
  }
}

Future<Entry> fetchWeatherByCity(City city) async {
  Map<String, String> params = {
    'lat': city.lat.toString(),
    'lon': city.lon.toString(),
    'appid': ApiConstants.apiKey,
    'units': 'metric'
  };

  var url = Uri.http(ApiConstants.baseUrl, ApiConstants.getWeather, params);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Entry model = Entry.fromJson(jsonDecode(response.body));
    return model;
  } else {
    throw Exception(
        'Failed to load city weather forecast for id: ${city.name}}');
  }
}

//Search
Future<List<City>> fetchCitiesByQuery(String q) async {
  Map<String, String> params = {
    'q': q,
    'appid': ApiConstants.apiKey,
    'limit': '5',
  };

  var url = Uri.http(ApiConstants.baseUrl, 'geo/1.0/direct', params);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List<City> model = List.from(jsonDecode(response.body))
        .map((e) => City.fromJson(e))
        .toList();
    return model;
  } else {
    throw Exception('Failed to load cities for query: $q');
  }
}
