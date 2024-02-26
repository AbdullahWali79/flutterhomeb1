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
  int n=4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          //callback fucntion, nameless function
          onTap:(){
            setState(() {
              n=Random().nextInt(6)+1;
            });
            print("N:$n");
          },
          child: Expanded(
            child: Image.asset('images/d$n.png'),
          ),
        ),
      ),
    );
  }
}
