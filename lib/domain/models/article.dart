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
}