import 'dart:convert';
import 'package:http/http.dart' as http;
import 'crypto_model.dart';

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
