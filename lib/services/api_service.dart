import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchAllCountries() async {
    const url = 'https://restcountries.com/v3.1/all';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
