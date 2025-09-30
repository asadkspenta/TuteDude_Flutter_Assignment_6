import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coin.dart';
import '../models/article.dart';
import '../models/movie.dart';
import '../models/joke.dart';
import '../models/quote.dart';

class ApiService {


  // Crypto
  Future<List<Coin>> fetchCoins() async {
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false"));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Coin.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load crypto");
    }
  }

  // News
   Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse("https://fakenews.squirro.com/news/sport"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['news'];
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load news");
    }
  }

  // Movies
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse("https://my-json-server.typicode.com/horizon-code-academy/fake-movies-api/movies"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  // Joke
  Future<Joke> fetchJoke() async {
    final response = await http.get(Uri.parse("https://v2.jokeapi.dev/joke/Any"));
    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load joke");
    }
  }

  // Quote
  Future<Quote> fetchQuote() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/quotes"));
    if (response.statusCode == 200) {
      return Quote.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load quote");
    }
  }
}
