import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';
import 'package:fluxo/ui/home/view/widgets/article_card.dart';
import 'package:fluxo/ui/home/view/widgets/feedback_widget.dart';
import 'package:fluxo/ui/home/view_model/category_state.dart';
import 'package:fluxo/ui/home/view_model/home_screen_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(homeScreenViewModelNotifier);
    final currentCategory = ref.watch(categoryStateNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fluxo",
          style: TextStyle(
            fontWeight: .bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final category = NewsCategories.values[index];
          
                          return FilterChip(
                            label: Text(category.frontEndName), 
                            selected: currentCategory == category,
                            onSelected: (selected) {
                              ref.read(homeScreenViewModelNotifier.notifier)
                                .updateCategory(category, selected);
                            },
                          );
                        },
                        separatorBuilder: (_, _) => SizedBox(width: 4,),
                        itemCount: NewsCategories.values.length,
                      ),
                    ),
                  ],
                ),
              ),
              articles.when(
                data: (articles) {
                  if(articles.isEmpty) {
                    return FeedbackWidget(
                      icon: Icon(Icons.air, size: 64,),
                      text: 'No articles were found!',
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, item) {
                      final article = articles[item];
                  
                      return ArticleCard(
                        article: article,
                        tapFunction: () async {
                          await launchUrl(article.url);
                        }
                      );
                    },
                    separatorBuilder: (_, _) => SizedBox(height: 8,), 
                    itemCount: articles.length
                  );
                }, 
                error: (_, _) {
                  return FeedbackWidget(
                    icon: Icon(Icons.error, size: 64,),
                    text: 'Could not load the articles!',
                  );
                }, 
                loading: () {
                  return Center(child: CircularProgressIndicator(),);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}