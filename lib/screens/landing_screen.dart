import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/strings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories_screen.dart';
import 'dashboard_screen.dart';
import 'nointernet_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class LandingScreen extends StatefulWidget {
  static const routeName = "/landingscreen";
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // var facebookLogin = FacebookLogin();

  List<Widget> sliderImages = [
    Image.asset(
      'assets/intro1.jpg',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/intro2.jpg',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/introimage3.jpg',
      fit: BoxFit.fill,
    ),
  ];

  void _socialMediaSignIn(
      String email, String phone, String fname, String imgUrl) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }
    setState(() {
      isLoading = true;
    });
    Map<String, String> params = {
      "apiMethod": "socialMediaLogin",
      "mailId": email,
      "phoneNumber": phone,
      "firstName": fname,
      "lastName": "",
      "profileImage": imgUrl
    };

    try {
      print(json.encode(params));
      Response response = await dio.post(socialMediaLogin, data: params);
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            authorizationKey, parsed['shoppeInformations']['authKey']);
        prefs.setString(
            profileImage, parsed['shoppeInformations']['profileImage']);
        prefs.setBool(isSignnedIn, true);
        if (parsed['userType'] == 'new') {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Categories.routeName, (Route<dynamic> route) => false);
          });
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Dashboard.routeName, (Route<dynamic> route) => false);
          });
        }

        //  Navigator.pop(context);
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  _loginWithFB() async {
    // final result = await facebookLogin.logIn([
    //   'email',
    // ]);
    //
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     final token = result.accessToken.token;
    //     final graphResponse = await http.get(
    //         'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
    //     final profile = JSON.jsonDecode(graphResponse.body);
    //     print(profile);
    //
    //     break;
    //
    //   case FacebookLoginStatus.cancelledByUser:
    //     break;
    //   case FacebookLoginStatus.error:
    //     break;
    // }
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  AnimationController controller;
  int _sliderCurrentIndex = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    controller.forward();

    _pageController.addListener(() {
      if (_pageController.page % 1 == 0) {
        _sliderCurrentIndex = _pageController.page.floor();
        print(_pageController.page);
        controller.reset();
        controller.forward();
      }
    });

    controller.addListener(() {
      if (controller.isCompleted) {
        if (_sliderCurrentIndex != 2) {
          controller.reset();
          _sliderCurrentIndex++;
          _pageController.animateToPage(_sliderCurrentIndex,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutQuad);
          //_pageController.jumpTo(_sliderCurrentIndex.toDouble());
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 12,
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    PageView(
                      controller: _pageController,
                      children: sliderImages,
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: ThemeColors.themeColor5,
                              ),
                            ),
                            SizedBox(
                              height: 28.0,
                            ),
                            Text(
                              "aFynder",
                              style: TextStyle(
                                  color: ThemeColors.themeColor5,
                                  fontSize: 28.0,
                                  fontFamily: 'pacifico'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              'One Stop App for All  ',
                              style: TextStyle(
                                  color: ThemeColors.themeColor5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Your Needs',
                              style: TextStyle(
                                  color: ThemeColors.themeColor5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 4.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: LinearProgressIndicator(
                                value: _sliderCurrentIndex == 0
                                    ? controller.value
                                    : _sliderCurrentIndex > 0
                                        ? 1.0
                                        : 0,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: _sliderCurrentIndex == 1
                                    ? controller.value
                                    : _sliderCurrentIndex > 1
                                        ? 1.0
                                        : 0,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: _sliderCurrentIndex == 2
                                    ? controller.value
                                    : _sliderCurrentIndex == 2
                                        ? 1.0
                                        : 0,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SocialMediaButton(
                            text: "Login wih Gmail",
                            buttonColor: Colors.redAccent,
                            prefixIcon: Icon(FontAwesome.google),
                            onTap: () async {
                              print('error');
                              _googleSignIn.signOut();
                              try {
                                await _googleSignIn.signIn();

                                print(_googleSignIn.currentUser.email);
                                _socialMediaSignIn(
                                    _googleSignIn.currentUser.email,
                                    "",
                                    _googleSignIn.currentUser.displayName,
                                    _googleSignIn.currentUser.photoUrl);
                              } catch (error) {
                                print(error);
                                Fluttertoast.showToast(
                                    msg: 'Something went wrong');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        EmailSignButton(
                          text: "Sign in",
                          onpressed: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        EmailSignButton(
                          text: "Sign up",
                          onpressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Skip Sign in Now",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String text;
  final Icon prefixIcon;
  final Color buttonColor;
  final Function onTap;

  const SocialMediaButton(
      {this.text, this.prefixIcon, this.buttonColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: RaisedButton(
          onPressed: onTap,
          padding: EdgeInsets.all(13.0),
          color: buttonColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              prefixIcon != null ? prefixIcon : SizedBox(),
              SizedBox(
                width: 16.0,
              ),
              Text(
                text,
                style:
                    TextStyle(color: ThemeColors.themeColor4, fontSize: 20.0),
              ),
            ],
          ),
          textColor: ThemeColors.themeColor4,
        ),
      ),
    );
  }
}

class EmailSignButton extends StatelessWidget {
  final String text;
  final Function onpressed;

  const EmailSignButton({this.text, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onpressed,
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      )),
      textColor: Colors.white,
      color: ThemeColors.themeOrange,
      padding: EdgeInsets.all(12.0),
    );
  }
}
