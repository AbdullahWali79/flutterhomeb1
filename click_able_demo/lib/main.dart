import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiceApp(),
    );
  }
}

class DiceApp extends StatefulWidget {
  const DiceApp({Key? key}) : super(key: key);

  @override
  State<DiceApp> createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int num = 1;
  int num1 = 1;
  int counter = 1;

  void Shuffle1() {
    if (num == 1) {
      num = 2;
      counter = counter + 2;
    } else if (num == 2) {
      num = 3;
      counter = counter + 3;
    } else if (num == 3) {
      num = 4;
      counter = counter + 4;
    } else if (num == 4) {
      num = 5;
      counter = counter + 5;
    } else if (num == 5) {
      num = 6;
      counter = counter + 6;
    } else {
      num = 1;
      counter = counter + 1;
    }
    if(counter>=200)
      counter=1;
  }

  void Shuffle2() {
    //int num1=1;
    if (num1 == 1)
      num1 = 2;
    else if (num1 == 2)
      num1 = 3;
    else if (num1 == 3)
      num1 = 4;
    else if (num1 == 4)
      num1 = 5;
    else if (num1 == 5)
      num1 = 6;
    else
      num1 = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                counter.toString(),
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Text(
                counter.toString(),
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Shuffle1();
                    });
                    print("Clicked");
                  },
                  child: Image(
                    image: AssetImage('images/d$num.png'),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Shuffle2();
                    });
                    print("Clicked");
                  },
                  child: Image(
                    image: AssetImage('images/d$num1.png'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
