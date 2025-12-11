import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

final apiServiceProvider = Provider<ApiService>((_) {
  return ApiService();
});

class ApiService {
  ApiService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  final http.Client _client;

  String baseApiUrl = "https://newsapi.org/v2/top-headlines?country=us";
  final apiKey = dotenv.env['API_KEY'];

  Future<List<dynamic>> getArticlesWithinCategory(String category) async {
    final response = await _client.get(
      Uri.parse('$baseApiUrl&category=$category'),
      headers: {'Authorization': apiKey!},
    );

    if(response.statusCode != 200) {
      return List.empty();
    }

    final data = jsonDecode(response.body)['articles'];
    return data;
  }
}