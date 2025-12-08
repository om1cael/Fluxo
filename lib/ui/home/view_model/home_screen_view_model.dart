import 'package:fluxo/data/repositories/article_repository.dart';
import 'package:fluxo/domain/models/article.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';

class HomeScreenViewModel {
  HomeScreenViewModel({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  final ArticleRepository _articleRepository;

  NewsCategories _category = NewsCategories.general;
  NewsCategories get category => _category;

  Future<List<Article>> fetchArticles() async {
    return await _articleRepository.getArticlesWithinCategory(_category.name);
  }

  void updateCategory(NewsCategories newCategory, bool isFilterSelected) {
    if(isFilterSelected) {
      _category = newCategory;
    } else {
      _category = NewsCategories.general;
    }
  }
}