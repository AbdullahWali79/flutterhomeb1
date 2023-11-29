import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_generater/screens/home_screen/home_screen.dart';
import 'package:table_generater/screens/login_screen/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);

    _user.bindStream(auth.userChanges());

    ever(_user, _intialScreen);
  }

  _intialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginScreen());
    } else {
      //Get.offAll(() => HomeScreen());
    }
  }

  void register(String email, password) {
    try {
      var result =
          auth.createUserWithEmailAndPassword(email: email, password: password);

      Get.to(HomeScreen());
    } catch (e) {
      Get.snackbar("About User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "ASD",
            style: TextStyle(color: Colors.amber),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.amber),
          ));
    }
  }

  void login(String email, password) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "ASD",
            style: TextStyle(color: Colors.amber),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.amber),
          ));
    }
  }
}
