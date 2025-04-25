class NewsModel {
  final String id;
  final String title;

  NewsModel({
    required this.id,
    required this.title,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
