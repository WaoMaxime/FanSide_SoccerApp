import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/match.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  Future<List<Match>> getLiveMatches() async {
    final response = await http.get(
      Uri.parse('$baseUrl/matches'),
      headers: {
        "X-Auth-Token": apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final matches = (data['matches'] as List)
          .map((m) => Match.fromJson(m))
          .toList();
      return matches;
    } else {
      throw Exception("Failed to load matches");
    }
  }
}
