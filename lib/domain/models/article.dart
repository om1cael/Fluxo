class Article {
  final String title;
  final String description;
  final String author;

  final Uri url;
  final DateTime publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'], 
      description: json['description'], 
      author: json['author'], 
      url: json['url'], 
      publishedAt: json['publishedAt']
    );
  }
}