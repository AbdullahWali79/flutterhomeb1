import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playSound(int soundNumber) {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/note$soundNumber.wav"),
      autoStart: true,
      showNotification: true,
    );
  }

  Expanded myWidget_Creator({Color? color, int? soundNumber, int flexibility=1}) {
    return Expanded(
      flex: flexibility,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: () {
          playSound(soundNumber!);
        }, child: Text(""), // Add your text as a child
      )
      ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              myWidget_Creator(soundNumber: 1,color: Colors.deepPurple,flexibility: 3),
              myWidget_Creator(soundNumber: 2,color: Colors.amberAccent),
              myWidget_Creator(soundNumber: 3,color: Colors.black),
              myWidget_Creator(soundNumber: 4,color: Colors.green),
              myWidget_Creator(soundNumber: 5,color: Colors.amberAccent),
              myWidget_Creator(soundNumber: 6,color: Colors.red),

            ],
          ),
        ),
      ),
    );
  }
}
