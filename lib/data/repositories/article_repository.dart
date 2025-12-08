import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxo/data/services/api_service.dart';
import 'package:fluxo/domain/models/article.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ArticleRepository(apiService: apiService);
});

class ArticleRepository {
  ArticleRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<Article>> getArticlesWithinCategory(String category) async {
    final response = await _apiService.getArticlesWithinCategory(category);
    return response.map((json) => Article.fromJson(json)).toList();
  }
}