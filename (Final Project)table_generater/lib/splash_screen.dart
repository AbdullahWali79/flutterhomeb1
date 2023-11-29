import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:table_generater/screens/login_screen/login_screen.dart';
import 'package:table_generater/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SplashScreenView(
        // navigateRoute: Home(),
        duration: 10000,
        imageSize: 200,
        backgroundColor: kBackgroundColor,
        imageSrc: 'assets/sp.png',
        text: "Table Generater App",
        textType: TextType.ColorizeAnimationText,
        colors: [Colors.green, kSecondaryColor, Colors.red],
        textStyle: TextStyle(
          fontSize: 24.0,
        ),
        navigateRoute: LoginScreen(),
      ),
    );
  }
}
