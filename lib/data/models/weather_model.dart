class Weather {
  final String cityName;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String description;
  final int dt;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.dt,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather0 = (json['weather'] as List).first;

    return Weather(
      cityName: json['name'] ?? '',
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: main['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      description: weather0['description'],
      dt: json['dt'],
      iconCode: weather0['icon'],
    );
  }

  /// ✅ NEW: Parse from One Call 3.0 API response
  factory Weather.fromOneCallJson(Map<String, dynamic> json) {
    final current = json['current'];
    final weather0 = (current['weather'] as List).first;

    return Weather(
      cityName: '', // The One Call API doesn’t return name
      temp: (current['temp'] as num).toDouble(),
      feelsLike: (current['feels_like'] as num).toDouble(),
      humidity: current['humidity'],
      windSpeed: (current['wind_speed'] as num).toDouble(),
      description: weather0['description'],
      dt: current['dt'],
      iconCode: weather0['icon'],
    );
  }
}
