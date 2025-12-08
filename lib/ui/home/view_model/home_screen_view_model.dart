import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxo/data/repositories/article_repository.dart';
import 'package:fluxo/domain/models/article.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';
import 'package:fluxo/ui/home/view_model/category_state.dart';

final homeScreenViewModelNotifier = AsyncNotifierProvider<HomeScreenViewModel, List<Article>>(
  HomeScreenViewModel.new
);

class HomeScreenViewModel extends AsyncNotifier<List<Article>> {
  @override
  FutureOr<List<Article>> build() async {
    final category = ref.watch(categoryStateNotifier);
    return await fetchArticles(category);
  }

  Future<List<Article>> fetchArticles(NewsCategories category) async {
    final articleRepository = ref.read(articleRepositoryProvider);
    return await articleRepository.getArticlesWithinCategory(category.name);
  }

  void updateCategory(NewsCategories newCategory) {
    ref.read(categoryStateNotifier.notifier)
      .setCategory(newCategory);
  }
}