// lib/data/repository/weather_repository.dart
import '../models/weather_model.dart';
import '../services/api_service.dart';

class WeatherRepository {
  final ApiService _apiService = ApiService();

  Future<Weather> getWeatherByCity(String city) {
    return _apiService.fetchWeatherByCity(city);
  }
}
