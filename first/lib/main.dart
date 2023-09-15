import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Practice App'),
        ),
        body: PracticeAppBody(),
      ),
    );
  }
}

class PracticeAppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Flutter!',
            style: TextStyle(fontSize: 24),
          ),
          Image.asset(
            'image/img.png', // Place your Flutter logo image in the 'assets' folder
            width: 150,
            height: 150,
          ),
          ElevatedButton(
            onPressed: () {
              print("Evelvated Button");
            },
            child: Text('Press Me'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 50,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 30,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Text(
              'This is a Container',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

