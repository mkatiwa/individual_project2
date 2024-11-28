import 'package:flutter/material.dart';

class CountryDetailsScreen extends StatelessWidget {
  final dynamic country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']['common']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Region: ${country['region']}'),
            Text('Population: ${country['population']}'),
            Text('Capital: ${country['capital']?.join(", ") ?? "N/A"}'),
            Text('Languages: ${country['languages'] != null ? country['languages'].values.join(", ") : "N/A"}'),
          ],
        ),
      ),
    );
  }
}
