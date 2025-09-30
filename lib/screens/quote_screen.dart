import 'dart:math';
import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/quote.dart';
import '../widgets/error_retry.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final ApiService apiService = ApiService();
  late Future<Quote> _quote;
  Quotes? _currentQuote; // currently displayed random quote
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _fetchAndPickRandomQuote();
  }

  void _fetchAndPickRandomQuote() {
    _quote = apiService.fetchQuote().then((quoteData) {
      if (quoteData.quotes != null && quoteData.quotes!.isNotEmpty) {
        // pick a random quote from the list
        _currentQuote = quoteData.quotes![_random.nextInt(quoteData.quotes!.length)];
      }
      return quoteData;
    });
  }

  void _getRandomQuote() {
    setState(() {
      _fetchAndPickRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quotes")),
      body: FutureBuilder<Quote>(
        future: _quote,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorRetry(
              message: snapshot.error.toString(),
              onRetry: _getRandomQuote,
            );
          } else if (_currentQuote != null) {
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
                            "\"${_currentQuote!.quote}\"",
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "- ${_currentQuote!.author ?? "Unknown"}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _getRandomQuote,
                    child: const Text("Get Random Quote"),
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
