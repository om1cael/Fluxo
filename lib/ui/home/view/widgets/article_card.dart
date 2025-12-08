import 'package:flutter/material.dart';
import 'package:fluxo/domain/models/article.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
    required this.tapFunction,
  });

  final Article article;
  final Function tapFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.lightGreen,
      onTap: () => tapFunction(),
      child: Card(
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
      ),
    );
  }
}