class Article {
  int? id;
  String? headline;
  String? abstractText;
  String? body;
  String? author;
  String? section;
  DateTime? date;
  String? articleUri;
  String? pdfUri;

  Article({
    this.id,
    this.headline,
    this.abstractText,
    this.body,
    this.author,
    this.section,
    this.date,
    this.articleUri,
    this.pdfUri,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int?,
      headline: json['headline'] as String?,
      abstractText: json['abstract'] as String?,
      body: json['body'] as String?,
      author: json['author'] as String?,
      section: json['section'] as String?,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      articleUri: json['article_uri'] as String?,
      pdfUri: json['pfd_uri'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'headline': headline,
        'abstract': abstractText,
        'body': body,
        'author': author,
        'section': section,
        'date': date?.toIso8601String(),
        'article_uri': articleUri,
        'pfd_uri': pdfUri,
      };
}
