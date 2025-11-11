import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config/api_keys.dart';
import '../models/weather_model.dart';

class ApiService {
  static const String _geoBase = 'https://api.openweathermap.org/geo/1.0';
  static const String _base = 'https://api.openweathermap.org/data/2.5';

  /// 🔹 Get weather using One Call 3.0 API (lat/lon)
  Future<Weather> fetchWeatherByCoordinates(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=${ApiKeys.openWeatherApiKey}',
    );

    debugPrint('🌍 Fetching weather (simple) for coordinates: ($lat, $lon)');
    debugPrint('🔗 URL: $url');

    try {
      final response = await http.get(url);
      debugPrint('📩 Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        debugPrint('❌ Error response: ${response.body}');
        throw Exception('Failed to load weather data');
      }

      final data = json.decode(response.body);
      debugPrint('✅ Weather data loaded successfully!');
      return Weather.fromJson(data);
    } catch (e, stack) {
      debugPrint('🚨 Error in fetchWeatherByCoordinates: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }

  /// 🔹 Convert city name → lat/lon using Geo API
  Future<Map<String, double>> getCoordinatesFromCity(String cityName) async {
    final url = Uri.parse(
      '$_geoBase/direct?q=${Uri.encodeComponent(cityName)}&limit=1&appid=${ApiKeys.openWeatherApiKey}',
    );

    debugPrint('📍 Fetching coordinates for city: $cityName');
    debugPrint('🔗 URL: $url');

    try {
      final response = await http.get(url);
      debugPrint('📩 Geo API response: ${response.statusCode}');

      if (response.statusCode != 200) {
        debugPrint('❌ Geo API Error: ${response.body}');
        throw Exception('Failed to fetch coordinates');
      }

      final List<dynamic> result = json.decode(response.body);
      if (result.isEmpty) {
        debugPrint('⚠️ City not found: $cityName');
        throw Exception('City not found');
      }

      final city = result.first;
      final lat = (city['lat'] as num).toDouble();
      final lon = (city['lon'] as num).toDouble();

      debugPrint('📍 Coordinates found: lat=$lat, lon=$lon');
      return {'lat': lat, 'lon': lon};
    } catch (e, stack) {
      debugPrint('🚨 Error in getCoordinatesFromCity: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }

  /// 🔹 Combined method: fetch by city name using both APIs
  Future<Weather> fetchWeatherByCity(String cityName) async {
    final url = Uri.parse(
      '$_base/weather?q=${Uri.encodeComponent(cityName)}&units=metric&appid=${ApiKeys.openWeatherApiKey}',
    );

    debugPrint('🌤 Fetching weather for city: $cityName');
    debugPrint('🔗 URL: $url');

    try {
      final response = await http.get(url);
      debugPrint('📩 Response status: ${response.statusCode}');

      if (response.statusCode != 200) {
        debugPrint('❌ Error response: ${response.body}');
        throw Exception('Failed to load weather for $cityName');
      }

      final data = json.decode(response.body);
      debugPrint('✅ Weather data loaded successfully for $cityName');

      return Weather.fromJson(data);
    } catch (e, stack) {
      debugPrint('🚨 Error in fetchWeatherByCity: $e');
      debugPrint(stack.toString());
      rethrow;
    }
  }
}
