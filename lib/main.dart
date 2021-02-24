import 'dart:io';

import 'package:afynder/response_models/productSearchSelection.dart';
import 'package:afynder/screens/all_categories.dart';
import 'package:afynder/screens/categories_screen.dart';
import 'package:afynder/screens/dashboard_screen.dart';
import 'package:afynder/screens/filter_screen.dart';
import 'package:afynder/screens/merchantprofile_screen.dart';
import 'package:afynder/screens/nointernet_screen.dart';
import 'package:afynder/screens/offermap_screen.dart';
import 'package:afynder/screens/paymenthistory_screen.dart';
import 'package:afynder/screens/productdetails_screen.dart';
import 'package:afynder/screens/profile_screen.dart';
import 'package:afynder/screens/search_screen.dart';
import 'package:afynder/screens/signin_screen.dart';
import 'package:afynder/screens/signup_screen.dart';
import 'package:afynder/screens/splash_screen.dart';
import 'package:afynder/screens/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'httpFi.dart';
import 'screens/sample_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/connectmerchant.dart';
import 'screens/forget_password_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(LoginScreen());
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductSearchParams(),
        ),
      ],
      child: MaterialApp(initialRoute: SplashScreen.routeName, routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        '/signin': (context) => SigninScreen(),
        Categories.routeName: (context) => Categories(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        Dashboard.routeName: (context) => Dashboard(),
        SplashScreen.routeName: (context) => SplashScreen(),
        AllCategories.routeName: (context) => AllCategories(),
        SearchScreen.routeName: (context) => SearchScreen(),
        NoInternet.routeName: (context) => NoInternet(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        '/productdetails': (context) => ProductDetails(),
        '/merchantdetails': (context) => MerchantProfile(),
        '/offermap': (context) => FilterScreen(),
        '/connect': (context) => ConnectMerchant(),
        '/paymenthistory': (context) => PaymentHistory(),
        '/wishlist': (context) => WishList()
      }),
    );
  }
}
