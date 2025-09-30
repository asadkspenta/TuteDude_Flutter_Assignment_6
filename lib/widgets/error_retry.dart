import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorRetry({required this.message, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: TextStyle(fontSize: 16, color: Colors.red)),
          SizedBox(height: 10),
          ElevatedButton(onPressed: onRetry, child: Text("Retry"))
        ],
      ),
    );
  }
}
