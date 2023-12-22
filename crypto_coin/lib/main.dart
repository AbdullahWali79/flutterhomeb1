import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Coin {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double highDay;
  final double lowDay;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.highDay,
    required this.lowDay,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['asset_id'],
      name: json['name'],
      symbol: json['asset_id'],
      price: json['price_usd'] ?? 0.0,
      highDay: json['high_day'] ?? 0.0,
      lowDay: json['low_day'] ?? 0.0,
    );
  }
}

class CoinApiService {
  static const String apiKey = 'BFF86FC4-456E-4505-ACB1-E3B10CE21E8E';
  static const String baseUrl = 'https://rest.coinapi.io/v1/assets';

  Future<List<Coin>> fetchCoinData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'X-CoinAPI-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class MyApp extends StatelessWidget {
  final CoinApiService coinApiService = CoinApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinAPI Crypto Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CoinListPage(coinApiService: coinApiService),
    );
  }
}

class CoinListPage extends StatefulWidget {
  final CoinApiService coinApiService;

  CoinListPage({Key? key, required this.coinApiService}) : super(key: key);

  @override
  _CoinListPageState createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  late Future<List<Coin>> futureCoins;

  @override
  void initState() {
    super.initState();
    futureCoins = widget.coinApiService.fetchCoinData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoinAPI Crypto Prices'),
      ),
      body: Center(
        child: FutureBuilder<List<Coin>>(
          future: futureCoins,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coin>? coins = snapshot.data;
              return ListView.builder(
                itemCount: coins!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(coins[index].name),
                    subtitle: Text(
                      'Price: \$${coins[index].price.toStringAsFixed(8)}\nHigh: \$${coins[index].highDay.toStringAsFixed(8)}\nLow: \$${coins[index].lowDay.toStringAsFixed(8)}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinDetailPage(coin: coins[index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class CoinDetailPage extends StatelessWidget {
  final Coin coin;

  CoinDetailPage({required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Details - ${coin.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${coin.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Name: ${coin.name}'),
            SizedBox(height: 10),
            Text('Symbol: ${coin.symbol}'),
            SizedBox(height: 10),
            Text('Price: \$${coin.price.toStringAsFixed(8)}'),
            SizedBox(height: 10),
            Text('High of the Day: \$${coin.highDay.toStringAsFixed(8)}'),
            SizedBox(height: 10),
            Text('Low of the Day: \$${coin.lowDay.toStringAsFixed(8)}'),
          ],
        ),
      ),
    );
  }
}
