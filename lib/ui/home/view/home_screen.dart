import 'package:flutter/material.dart';
import 'package:fluxo/domain/models/article.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';
import 'package:fluxo/ui/home/view/widgets/article_card.dart';
import 'package:fluxo/ui/home/view/widgets/feedback_widget.dart';
import 'package:fluxo/ui/home/view_model/home_screen_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required HomeScreenViewModel viewModel,
  }) : _viewModel = viewModel;

  final HomeScreenViewModel _viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsCategories categoryFilter = NewsCategories.general;
  late Future<List<Article>> _fetchArticlesFuture;

  @override
  void initState() {
    super.initState();

    _fetchArticlesFuture = widget._viewModel.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
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
                            selected: widget._viewModel.category == category,
                            onSelected: (selected) {
                              setState(() {
                                widget._viewModel.updateCategory(category, selected);
                                _fetchArticlesFuture = widget._viewModel.fetchArticles();
                              });
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
              FutureBuilder(
                future: _fetchArticlesFuture, 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }
                          
                  if((snapshot.hasError || !snapshot.hasData)) {
                    return FeedbackWidget(
                      icon: Icon(Icons.error, size: 64,),
                      text: 'Could not load the articles!',
                    );
                  }
                        
                  if(snapshot.data!.isEmpty) {
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
                      final article = snapshot.data![item];
                  
                      return ArticleCard(
                        article: article,
                        tapFunction: () async {
                          await launchUrl(article.url);
                        }
                      );
                    },
                    separatorBuilder: (_, _) => SizedBox(height: 8,), 
                    itemCount: snapshot.data!.length
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}