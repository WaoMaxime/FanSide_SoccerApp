import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/match.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  Future<List<Match>> getLiveMatches() async {
    final url = Uri.parse('$baseUrl/fixtures?live=all');
    try {
      final response = await http.get(
        url,
        headers: {
          'x-apisports-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Match> matches = (data['response'] as List)
            .map((json) => Match.fromApi(json))
            .toList();

        return matches;
      } else {
        throw Exception(
            "Failed to fetch live matches: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
