import 'package:flutter/material.dart';
import 'package:splash/Screens/signin.dart';
import 'package:splash/Screens/signup.dart';

class authenticate extends StatefulWidget {
  const authenticate({Key? key}) : super(key: key);

  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {
  @override
  Widget build(BuildContext context) {
    bool showSignIn = true;
    void switching() {
      setState(() {
        showSignIn = !showSignIn;
      });
    }

    if (showSignIn) {
      return SignIn(switching);
    } else {
      return SignUp(switching);
    }
  }
}
