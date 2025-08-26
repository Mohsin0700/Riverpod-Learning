import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_learning/config/app_config.dart';

class RemoteService {
  static Future getData() async {
    final response = await http.get(Uri.parse('$baseUrl/unicorns'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future postData(data) async {
    print(data);
    try {
      final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.parse('$baseUrl/unicorns'),
        body: jsonEncode(data),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }
}
