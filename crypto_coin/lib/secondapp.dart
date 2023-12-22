// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(MyApp());
// }
//
// class CryptoData {
//   final String name;
//   final String symbol;
//   final double price;
//   final double high;
//   final double low;
//
//   CryptoData({
//     required this.name,
//     required this.symbol,
//     required this.price,
//     required this.high,
//     required this.low,
//   });
//
//   factory CryptoData.fromJson(Map<String, dynamic> json) {
//     return CryptoData(
//       name: json['2. name'],
//       symbol: json['1. symbol'],
//       price: double.parse(json['4. close']),
//       high: double.parse(json['3. high']),
//       low: double.parse(json['5. low']),
//     );
//   }
// }
//
// class CryptoService {
//   static const String apiKey = 'C0Z4YGR4D7DK392J';
//   static const String baseUrl =
//       'https://www.alphavantage.co/query?function=DIGITAL_CURRENCY_DAILY&symbol=BTC&market=USD&apikey=$apiKey';
//
//   Future<List<CryptoData>> fetchCryptoData() async {
//     final response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> decodedData = jsonDecode(response.body)['Time Series (Digital Currency Daily)'];
//       final List<CryptoData> cryptoList = [];
//
//       decodedData.forEach((key, value) {
//         final crypto = CryptoData.fromJson(value);
//         cryptoList.add(crypto);
//       });
//
//       return cryptoList;
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final CryptoService cryptoService = CryptoService();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crypto Prices',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(cryptoService: cryptoService),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   final CryptoService cryptoService;
//
//   MyHomePage({Key? key, required this.cryptoService}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Future<List<CryptoData>> futureCryptoData;
//
//   @override
//   void initState() {
//     super.initState();
//     futureCryptoData = widget.cryptoService.fetchCryptoData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crypto Prices'),
//       ),
//       body: Center(
//         child: FutureBuilder<List<CryptoData>>(
//           future: futureCryptoData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<CryptoData>? cryptoList = snapshot.data;
//               return ListView.builder(
//                 itemCount: cryptoList!.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(cryptoList[index].name),
//                     subtitle: Text(cryptoList[index].symbol),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CryptoDetailsScreen(
//                             cryptoData: cryptoList[index],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class CryptoDetailsScreen extends StatelessWidget {
//   final CryptoData cryptoData;
//
//   CryptoDetailsScreen({required this.cryptoData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details - ${cryptoData.name}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Current Price: \$${cryptoData.price.toStringAsFixed(8)}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Table(
//               border: TableBorder.all(),
//               children: [
//                 TableRow(
//                   children: [
//                     TableCell(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('Today\'s High'),
//                       ),
//                     ),
//                     TableCell(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('\$${cryptoData.high.toStringAsFixed(8)}'),
//                       ),
//                     ),
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     TableCell(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('Today\'s Low'),
//                       ),
//                     ),
//                     TableCell(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('\$${cryptoData.low.toStringAsFixed(8)}'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
