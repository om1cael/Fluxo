import 'package:flutter/material.dart';
import 'package:fluxo/domain/models/enum/news_categories.dart';
import 'package:fluxo/ui/home/view_model/home_screen_view_model.dart';

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
  Set<NewsCategories> categoryFilter = {};

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,),
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
                              selected: categoryFilter.contains(category),
                              onSelected: (selected) {
                                setState(() {
                                  if(selected) {
                                    categoryFilter.add(category);
                                  } else {
                                    categoryFilter.remove(category);
                                  }

                                  if(categoryFilter.isEmpty) {
                                    categoryFilter.add(NewsCategories.general);
                                  }
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
                  future: widget._viewModel.getAllArticles(), 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    }
                            
                    if((snapshot.hasError || !snapshot.hasData) || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Could not load the articles.'),
                      );
                    }
                            
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, item) {
                        final article = snapshot.data![item];
                    
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: .stretch,
                              children: [
                                Text(
                                  article.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4,),
                                Text(
                                  article.publishedAt.toLocal().toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  article.description,
                                  maxLines: 6,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 4,),
                                    Flexible(
                                      child: Text(
                                        article.author, 
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          letterSpacing: .1,
                                          fontSize: 10
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
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
      ),
    );
  }
}