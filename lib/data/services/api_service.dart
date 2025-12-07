import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

class ApiService {
  String baseApiUrl = "https://newsapi.org/v2/top-headlines?country=us";
  final apiKey = dotenv.env['API_KEY'];

  Future<List<dynamic>> getArticles() async {
    final response = await http.get(
      Uri.parse(baseApiUrl),
      headers: {'Authorization': apiKey!},
    );

    if(response.statusCode != 200) {
      return List.empty();
    }

    final data = jsonDecode(response.body)['articles'];
    return data;
  }

  Future<List<dynamic>> getArticlesWithinCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseApiUrl?category=$category'),
      headers: {'Authorization': apiKey!},
    );

    if(response.statusCode != 200) {
      return List.empty();
    }

    final data = jsonDecode(response.body)['articles'];
    return data;
  }
}