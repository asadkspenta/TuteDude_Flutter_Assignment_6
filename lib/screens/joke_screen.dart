import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/joke.dart';
import '../widgets/error_retry.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final ApiService apiService = ApiService();
  late Future<Joke> _joke;

  @override
  void initState() {
    super.initState();
    _fetchRandomJoke();
  }

  void _fetchRandomJoke() {
    setState(() {
      _joke = apiService.fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jokes")),
      body: FutureBuilder<Joke>(
        future: _joke,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorRetry(
              message: snapshot.error.toString(),
              onRetry: _fetchRandomJoke,
            );
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            joke.setup,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          if (joke.delivery != null)
                            Text(
                              joke.delivery!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _fetchRandomJoke,
                    child: const Text("Get Random Joke"),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
