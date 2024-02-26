import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DicewithStatfull(),
    );
  }
}

class DicewithStatfull extends StatefulWidget {
  @override
  State<DicewithStatfull> createState() => _State();
}

class _State extends State<DicewithStatfull> {
  int n = 4;
  int n1=1;
  int n2=2;
  int n3=3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  //callback fucntion, nameless function
                  onTap: () {
                    setState(() {
                      n = Random().nextInt(6) + 1;
                    });
                    print("N:$n");
                  },
                  child: Image.asset('images/d$n.png'),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  //callback fucntion, nameless function
                  onTap: () {
                    setState(() {
                      n1 = Random().nextInt(6) + 1;
                    });
                    print("N:$n");
                  },
                  child: Image.asset('images/d$n1.png'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  //callback fucntion, nameless function
                  onTap: () {
                    setState(() {
                      n2 = Random().nextInt(6) + 1;
                    });
                    print("N:$n2");
                  },
                  child: Image.asset('images/d$n2.png'),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  //callback fucntion, nameless function
                  onTap: () {
                    setState(() {
                      n3 = Random().nextInt(6) + 1;
                    });
                    print("N:$n3");
                  },
                  child: Image.asset('images/d$n3.png'),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
