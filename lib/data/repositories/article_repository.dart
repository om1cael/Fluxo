import 'package:fluxo/data/services/api_service.dart';
import 'package:fluxo/domain/models/article.dart';

class ArticleRepository {
  ArticleRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<Article>> getAllArticles() async {
    final response = await _apiService.getArticles();
    return response.map((json) => Article.fromJson(json)).toList();
  }
}