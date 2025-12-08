import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';

final categoryStateNotifier = NotifierProvider<CategoryState, NewsCategories>(
  CategoryState.new
);

class CategoryState extends Notifier<NewsCategories> {  
  @override
  NewsCategories build() {
    return NewsCategories.general;
  }

  void setCategory(NewsCategories newCategory) {
    state = newCategory;
  }
}