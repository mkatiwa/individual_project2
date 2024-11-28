import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    // Initially, the filtered list is empty
    _filteredCountries = Provider.of<CountryProvider>(context, listen: false).countries;
    // Listen to text field changes
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    final provider = Provider.of<CountryProvider>(context, listen: false);

    if (query.isEmpty) {
      setState(() {
        _filteredCountries = provider.countries;
      });
    } else {
      setState(() {
        _filteredCountries = provider.countries.where((country) {
          final name = country['name']['common'].toLowerCase();
          return name.contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search By Country Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: countryProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCountries.isEmpty
                    ? const Center(
                        child: Text(
                          'No countries found. Try a different search.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(country['name']['common']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Population: ${country['population']}'),
                                  Text('Region: ${country['region']}'),
                                  if (country['capital'] != null)
                                    Text('Capital: ${country['capital'][0]}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countryProvider.fetchAllCountries();
          _searchController.clear();
          setState(() {
            _filteredCountries = countryProvider.countries;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
