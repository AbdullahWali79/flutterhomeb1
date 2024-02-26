import 'package:flutter/material.dart'; //why?

void main() {
  print('This is Just Dart for Testing Purpose!');
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  const MyFirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('First App'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center-align children vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center-align children horizontally
          children: [
            Text(
              "Abdullah",
              style: TextStyle(
                color: Colors.green,
                fontSize: 50,
              ),
            ),
            SizedBox(height: 10), // Add some space between text and image
            // Image.network(
            //   height: 150,
            //     width: 130,
            //     'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
            // Image.network(
            //     height: 150,
            //     width: 130,
            //     "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            Expanded(child: Image.asset('images/my_image.png')),

          ],
        ),
      ),
    );
  }
}

/*
Text(
            "Abdullah",
            style: TextStyle(
              color: Colors.green,
              fontSize: 50,
            ),
          ),
        ),
 */
