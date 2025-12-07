import 'package:fluxo/data/repositories/article_repository.dart';
import 'package:fluxo/domain/models/article.dart';

class HomeScreenViewModel {
  HomeScreenViewModel({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  final ArticleRepository _articleRepository;

  Future<List<Article>> getAllArticles() async {
    return await _articleRepository.getAllArticles();
  }
}