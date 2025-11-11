// lib/providers/weather_provider.dart
import 'package:flutter/material.dart';
import '../data/models/weather_model.dart';
import '../data/repository/weather_repository.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository = WeatherRepository();

  WeatherState _state = WeatherState.initial;
  WeatherState get state => _state;

  Weather? _weather;
  Weather? get weather => _weather;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _state = WeatherState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final w = await _repository.getWeatherByCity(city);
      _weather = w;
      _state = WeatherState.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = WeatherState.error;
      notifyListeners();
    }
  }
}
