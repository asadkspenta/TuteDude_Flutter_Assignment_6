import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/movie.dart';
import '../widgets/error_retry.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = apiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: FutureBuilder<List<Movie>>(
        future: _movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorRetry(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(() {
                  _movies = apiService.fetchMovies();
                });
              },
            );
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: movie.poster != null
                        ? Image.network(
                            movie.poster!,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 50,
                            color: Colors.grey,
                            child: const Icon(Icons.movie),
                          ),
                    title: Text(movie.title ?? "Unknown Title"),
                    subtitle: Text(
                      "${movie.year ?? "Unknown Year"} | ${movie.runtime ?? "Unknown Runtime"}",
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
