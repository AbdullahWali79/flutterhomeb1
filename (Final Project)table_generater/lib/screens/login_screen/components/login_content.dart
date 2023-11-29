import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_generater/screens/home_screen/home_screen.dart';
import 'package:table_generater/utils/helper_functions.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/constants.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  AuthController controller = AuthController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget inputField(
    String hint,
    IconData iconData,
    TextEditingController controller,
    FormFieldValidator validator,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            controller: controller,
            validator: validator,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(iconData),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(
    String title,
    VoidCallback onpressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
      inputField(
        'Username',
        Ionicons.person_outline,
        _username,
        (value) {
          if (value!.isEmpty) {
            return 'Please enter username';
          }
          return null;
        },
      ),
      inputField(
        'Email',
        Ionicons.mail_outline,
        _email,
        (value) {
          if (value!.isEmpty) {
            return 'Please enter an email';
          }
          if (!EmailValidator.validate(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
      ),
      inputField(
        'Password',
        Ionicons.lock_closed_outline,
        _password,
        (value) {
          if (value!.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }

          return null;
        },
      ),
      loginButton('Sign Up', () async {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );
          FirebaseFirestore.instance
              .collection('tusers')
              .doc(userCredential.user?.uid)
              .collection('profile')
              .doc()
              .set({
            "username": _username.text,
            'email': _email.text.trim(),
            'image':
                'https://orphanage1919.org/wp-content/uploads/Committee/gs.jpg',
          });
          if (userCredential != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
          //Get.to(HomeScreen());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (e.code == 'email-already-in-use') {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      }),
    ];

    loginContent = [
      inputField(
        'Email / Username',
        Ionicons.mail_outline,
        _email,
        (value) {
          if (value!.isEmpty) {
            return 'Please enter an email';
          }
          if (!EmailValidator.validate(value)) {
            return 'Enter a valid email address';
          }
          return null;
        },
      ),
      inputField(
        'Password',
        Ionicons.lock_closed_outline,
        _password,
        (value) {
          if (value!.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),
      loginButton('Log In', () async {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          );
          if (userCredential != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (e.code == 'wrong-password') {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                e.toString(),
                style: TextStyle(color: Colors.white),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      }),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}
