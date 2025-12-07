import 'package:flutter/material.dart';
import 'package:fluxo/ui/home/view_model/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required HomeScreenViewModel viewModel,
  }) : _viewModel = viewModel;

  final HomeScreenViewModel _viewModel;

  final categories = <String>[
    "General",
    "Technology",
    "Science",
    "Entertainment",
    "Sports",
    "Health",
    "Business",
  ];

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
                          itemBuilder: (_, item) {
                            return FilterChip(
                              label: Text(categories[item]), 
                              onSelected: (value) {}
                            );
                          }, 
                          separatorBuilder: (_, _) => SizedBox(width: 8,), 
                          itemCount: categories.length
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _viewModel.getAllArticles(), 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    }
            
                    if(snapshot.hasError || !snapshot.hasData) {
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