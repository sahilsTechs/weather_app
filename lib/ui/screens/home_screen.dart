import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import 'search_city_screen.dart';
import '../../core/utils/date_formatter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController(
    text: 'London',
  );

  @override
  void initState() {
    super.initState();
    // Load default city
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).fetchWeather(_cityController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SearchCityScreen()),
              );
              if (result != null && result is String) {
                _cityController.text = result;
                provider.fetchWeather(result);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.blueGrey.shade900]
                : [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildBody(provider),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(WeatherProvider provider) {
    switch (provider.state) {
      case WeatherState.initial:
      case WeatherState.loading:
        return const Center(
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        );

      case WeatherState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12),
              Text(
                provider.errorMessage ?? 'Something went wrong',
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  provider.fetchWeather(_cityController.text);
                },
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );

      case WeatherState.loaded:
        final w = provider.weather!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              w.cityName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            WeatherCard(weather: w),
            const SizedBox(height: 16),
            Text(
              DateFormatter.formatTimestamp(w.dt),
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                provider.fetchWeather(_cityController.text);
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Refresh',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
    }
  }
}
