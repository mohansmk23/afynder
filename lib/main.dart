import 'package:afynder/screens/signin_screen.dart';
import 'package:afynder/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/signin_screen.dart';
import 'screens/landing_screen.dart';

void main() => runApp(LoginScreen());

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => LandingScreen(),
    });
  }
}
