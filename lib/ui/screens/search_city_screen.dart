// lib/ui/screens/search_city_screen.dart
import 'package:flutter/material.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({super.key});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search city')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'City name',
                hintText: 'e.g. Mumbai, London',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.of(context).pop(text);
    }
  }
}
