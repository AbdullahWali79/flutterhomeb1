import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final apiKey = '158967843a4e4cf212969a5b6480d58c';
  String city = 'Vehari'; // Set initial value to match a predefined city
  String temperature = '';
  final cityController = TextEditingController();
  final List<String> predefinedCities = ['Vehari', 'Multan', 'Lahore', 'Karachi'];

  @override
  void initState() {
    super.initState();
    _fetchWeatherData(city);
  }

  Future<void> _fetchWeatherData(String city) async {
    final url =
    Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      final mainData = weatherData['main'];
      setState(() {
        temperature = '${mainData['temp']}°C';
      });
    } else {
      // Handle error
    }
  }

  void _updateWeather() {
    setState(() {
      city = cityController.text;
    });
    _fetchWeatherData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: city,
                onChanged: (newValue) {
                  setState(() {
                    city = newValue!;
                  });
                },
                items: predefinedCities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: Colors.white,),),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              FloatingActionButton(
                onPressed: _updateWeather,
                tooltip: 'Get Weather',
                child: Icon(Icons.cloud),
              ),
              SizedBox(height: 16),
              Text(
                'Temperature:',
                style: TextStyle(fontSize: 40,color: Colors.white,),
              ),
              SizedBox(height: 16),
              Text(
                temperature,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cityController.clear();
        },
        tooltip: 'Add City',
        child: Icon(Icons.add),
      ),
    );
  }
}
