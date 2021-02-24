import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/screens/signin_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'landing_screen.dart';
import 'nointernet_screen.dart';

class ForgotPassword extends StatefulWidget {
  static var routeName = 'forgotPass';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false, _isVerified = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: _isVerified
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: ThemeColors.themeOrange,
                    child: Image.asset(
                      'assets/paperplane.gif',
                      height: 300.0,
                      width: 300.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Verification successful !',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'We have sent you an email with password reset instruction. Please check your registered email id and follow the instruction given!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: EmailSignButton(
                    text: "Try Logging in",
                    onpressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/forgotpass.png',
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Please Enter Email or Mobile number to verify your account',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w100,
                        decoration: TextDecoration.none),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RectFormField(
                      hint: 'Email ID / Mobile Number',
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Email ID / Mobile number';
                        } else {
                          email = value;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: isLoading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    width: 22.0,
                                    height: 22.0,
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Text(
                                  "Verifying",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ],
                            )
                          : Text(
                              "Verify & Continue",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                      color: ThemeColors.themeOrange,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _verify();
                        } else {}
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _verify() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }
    setState(() {
      isLoading = true;
    });
    Map<String, String> params = {
      "apiMethod": "forgotPassword",
      "userName": email,
      "mobileUniqueCode": "sdsd"
    };

    try {
      print(json.encode(params));
      Response response;
      response = await dio.post(forgotPassword, data: params);
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        setState(() {
          _isVerified = true;
        });
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

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
