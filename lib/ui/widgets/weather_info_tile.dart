// lib/ui/widgets/weather_info_tile.dart
import 'package:flutter/material.dart';

class WeatherInfoTile extends StatelessWidget {
  final String label;
  final String value;
  const WeatherInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
