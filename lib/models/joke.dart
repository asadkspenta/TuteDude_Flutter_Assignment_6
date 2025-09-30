class Joke {
  final String setup;
  final String? delivery;
  final String? joke;

  Joke({required this.setup, this.delivery, this.joke});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'] ?? json['joke'] ?? '',
      delivery: json['delivery'],
      joke: json['joke'],
    );
  }
}
