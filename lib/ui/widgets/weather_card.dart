// lib/ui/widgets/weather_card.dart
import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  String _iconUrl(String iconCode) {
    // OpenWeather icon URL
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  _iconUrl(weather.iconCode),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temp.toStringAsFixed(1)} °C',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                _infoTile(
                  'Feels like',
                  '${weather.feelsLike.toStringAsFixed(1)} °C',
                ),
                _infoTile('Humidity', '${weather.humidity}%'),
                _infoTile('Wind', '${weather.windSpeed} m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
