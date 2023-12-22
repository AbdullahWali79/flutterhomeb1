import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class Coin {
  final String name;
  final String symbol;
  final double price;
  final double high;
  final double low;

  Coin({
    required this.name,
    required this.symbol,
    required this.price,
    required this.high,
    required this.low,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      price: json['quote']['USD']['price'] != null ? json['quote']['USD']['price'].toDouble() : 0.0,
      high: json['quote']['USD']['high_24h'] != null ? json['quote']['USD']['high_24h'].toDouble() : 0.0,
      low: json['quote']['USD']['low_24h'] != null ? json['quote']['USD']['low_24h'].toDouble() : 0.0,
    );
  }
}

class CoinMarketCapService {
  static const String apiKey = 'f8c6f93a-924e-4ef3-81a6-950c30fca23e'; // Replace with your API key
  static const String baseUrl =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

  Future<List<Coin>> fetchCryptoData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'X-CMC_PRO_API_KEY': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class MyApp extends StatelessWidget {
  final CoinMarketCapService coinMarketCapService = CoinMarketCapService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Prices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(coinMarketCapService: coinMarketCapService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CoinMarketCapService coinMarketCapService;

  MyHomePage({Key? key, required this.coinMarketCapService}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Coin>> futureCoins;
  late List<Coin> displayedCoins;

  @override
  void initState() {
    super.initState();
    futureCoins = widget.coinMarketCapService.fetchCryptoData();
    displayedCoins = [];
  }

  void _searchCoins(String query) {
    setState(() {
      displayedCoins = displayedCoins.where((coin) {
        return coin.name.toLowerCase().contains(query.toLowerCase()) ||
            coin.symbol.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch(
                context: context,
                delegate: _CoinSearch(displayedCoins),
              );
              if (query != null) {
                _searchCoins(query);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Coin>>(
          future: futureCoins,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coin>? coins = snapshot.data;
              displayedCoins = coins!;
              return ListView.builder(
                itemCount: displayedCoins.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(displayedCoins[index].name),
                    subtitle: Text(displayedCoins[index].symbol),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinDetailsScreen(
                            coin: displayedCoins[index],
                          ),
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

class _CoinSearch extends SearchDelegate<String> {
  final List<Coin> coins;

  _CoinSearch(this.coins);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // No need to implement as we update results instantly
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Coin> suggestedCoins = query.isEmpty
        ? coins
        : coins.where((coin) {
      return coin.name.toLowerCase().contains(query.toLowerCase()) ||
          coin.symbol.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestedCoins.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestedCoins[index].name),
          subtitle: Text(suggestedCoins[index].symbol),
          onTap: () {
            close(context, suggestedCoins[index].name);
          },
        );
      },
    );
  }
}

class CoinDetailsScreen extends StatelessWidget {
  final Coin coin;

  CoinDetailsScreen({required this.coin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details - ${coin.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Price: \$${coin.price.toStringAsFixed(8)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Today\'s High'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$${coin.high.toStringAsFixed(8)}'),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Today\'s Low'),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\$${coin.low.toStringAsFixed(8)}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
