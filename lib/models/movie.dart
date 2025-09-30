class Movie {
  String? title;
  String? year;
  String? runtime;
  String? poster;

  Movie({this.title, this.year, this.runtime, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] as String?,
      year: json['Year'] as String?,
      runtime: json['Runtime'] as String?,
      poster: json['Poster'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'Runtime': runtime,
        'Poster': poster,
      };
}
