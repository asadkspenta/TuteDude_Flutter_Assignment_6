import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:flutter_html/flutter_html.dart';


class NewsDetailScreen extends StatelessWidget {
  final Article article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.headline ?? "News Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.author != null)
                Text("By ${article.author!}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              if (article.date != null)
                Text("${article.date!.toLocal()}".split(' ')[0], style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              if (article.body != null)
                Html(
                  data: article.body!,
                  style: {
                    "p": Style(
                      margin: Margins(
                        left: Margin.auto(),
                        right: Margin.auto(),
                      ), // <-- use Margins(vertical: 8)
                    ),
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
