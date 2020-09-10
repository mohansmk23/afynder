import 'package:afynder/screens/categories_screen.dart';
import 'package:afynder/screens/dashboard_screen.dart';
import 'package:afynder/screens/filter_screen.dart';
import 'package:afynder/screens/merchantprofile_screen.dart';
import 'package:afynder/screens/offermap_screen.dart';
import 'package:afynder/screens/paymenthistory_screen.dart';
import 'package:afynder/screens/productdetails_screen.dart';
import 'package:afynder/screens/profile_screen.dart';
import 'package:afynder/screens/signin_screen.dart';
import 'package:afynder/screens/signup_screen.dart';
import 'package:afynder/screens/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/sample_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/connectmerchant.dart';

void main() => runApp(LoginScreen());

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => LandingScreen(),
      '/signin': (context) => SigninScreen(),
      Categories.routeName: (context) => Categories(),
      '/signup': (context) => SignUpScreen(),
      '/profile': (context) => ProfileScreen(),
      Dashboard.routeName: (context) => Dashboard(),
      '/productdetails': (context) => ProductDetails(),
      '/merchantdetails': (context) => MerchantProfile(),
      '/offermap': (context) => FilterScreen(),
      '/connect': (context) => ConnectMerchant(),
      '/paymenthistory': (context) => PaymentHistory(),
      '/wishlist': (context) => WishList()
    });
  }
}
