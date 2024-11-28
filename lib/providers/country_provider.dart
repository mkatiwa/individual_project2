import 'package:flutter/foundation.dart';
import '../services/api_service.dart';

class CountryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _countries = [];
  bool _isLoading = false;

  List<dynamic> get countries => _countries;
  bool get isLoading => _isLoading;

  Future<void> fetchAllCountries() async {
    _isLoading = true;
    notifyListeners();
    try {
      _countries = await _apiService.fetchAllCountries();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching countries: $e');
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}
