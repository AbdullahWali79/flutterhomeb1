import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_search_bar/easy_search_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CryptoListScreen(),
    );
  }
}

class Crypto {
  final String id;
  final String name;
  final String symbol;
  final double priceUsd;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.priceUsd,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: double.parse(json['priceUsd']),
    );
  }
}

class CoincapService {
  final String baseUrl = 'https://api.coincap.io/v2';

  Future<List<Crypto>> getCryptoData() async {
    String apiUrl = '$baseUrl/assets?limit=50'; // Fetching 50 cryptocurrencies
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> cryptoList = data['data'];

      return cryptoList.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cryptocurrency data');
    }
  }
}

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late CoincapService _coincapService;
  late List<Crypto> _cryptoList;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _coincapService = CoincapService();
    _cryptoList = [];
    _controller = TextEditingController();

    _loadCryptoData();
  }

  void _loadCryptoData() async {
    try {
      List<Crypto> data = await _coincapService.getCryptoData();
      setState(() {
        _cryptoList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<Crypto> _searchCrypto(String searchQuery) {
    return _cryptoList.where((crypto) {
      return crypto.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          crypto.symbol.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrency List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: EasySearchBar(
              controller: _controller,
              hintText: 'Search...',
              onTextChanged: (text) {
                setState(() {});
              }, title: Text("Just Test"), onSearch: (String ) {  },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchCrypto(_controller.text).length,
              itemBuilder: (BuildContext context, int index) {
                Crypto crypto = _searchCrypto(_controller.text)[index];
                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text('${crypto.symbol} - \$${crypto.priceUsd.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
