import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';
import 'models/city_model.dart';

Future<City> fetchForecastByCityId(String cityId) async {
  Map<String, String> params = {
    'id': cityId,
    'appid': ApiConstants.apiKey,
    'units': 'metric'
  };

  var url =
      Uri.http(ApiConstants.baseUrl, ApiConstants.getWeatherForcast, params);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    City model = City.fromJson(jsonDecode(response.body));
    return model;
  } else {
    throw Exception('Failed to load city weather forecast for id: $cityId');
  }
}

Future<Entry> fetchWeatherByCityId(String cityId) async {
  Map<String, String> params = {
    'id': cityId,
    'appid': ApiConstants.apiKey,
    'units': 'metric'
  };

  var url = Uri.http(ApiConstants.baseUrl, ApiConstants.getWeather, params);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Entry model = Entry.fromJson(jsonDecode(response.body));
    return model;
  } else {
    throw Exception('Failed to load city weather forecast for id: $cityId');
  }
}
