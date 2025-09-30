import 'package:flutter/material.dart';
import '../core/api_service.dart';
import '../models/coin.dart';
import '../widgets/error_retry.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Coin>> _coins;

  @override
  void initState() {
    super.initState();
    _coins = apiService.fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Coin>>(
        future: _coins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorRetry(
              message: snapshot.error.toString(),
              onRetry: () {
                setState(() {
                  _coins = apiService.fetchCoins();
                });
              },
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final coin = snapshot.data![index];
                return ListTile(
                  leading: Image.network(coin.image, width: 40),
                  title: Text(coin.name),
                  subtitle: Text(coin.symbol.toUpperCase()),
                  trailing: Text("\$${coin.price.toStringAsFixed(2)}"),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
