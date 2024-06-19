import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchData() async {
  try {
    final response =
        await http.get(Uri.parse('https://naradha.in/includes/appapi.php'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData != null && jsonData is List) {
        return jsonData;
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } on SocketException catch (e) {
    throw Exception('No internet connection: ${e.message}');
  } catch (e) {
    throw Exception('An error occurred: $e');
  }
}
