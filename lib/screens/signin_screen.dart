import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/login_model.dart';
import 'package:afynder/screens/categories_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:afynder/main.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import 'dashboard_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String email, password;
  Response response;

  void signIn() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> params = {
      "apiMethod": "shopeeLogin",
      "username": email,
      "password": password,
      "mobileUniqueCode": "jana1221"
    };

    try {
      print(json.encode(params));
      response = await dio.post(signInRequest, data: params);
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final LoginModel model = LoginModel.fromJson(parsed);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(firstNameKey, model.shoppeInformations.firstName);
        prefs.setString(lastNameKey, model.shoppeInformations.lastName);
        prefs.setString(mailIdKey, model.shoppeInformations.mailId);
        prefs.setString(authorizationKey, model.shoppeInformations.authKey);
        prefs.setString(shopeeId, model.shoppeInformations.shopeeId);
        prefs.setString(profileImage, model.shoppeInformations.profileImage);
        prefs.setBool(isSignnedIn, true);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Dashboard.routeName, (Route<dynamic> route) => false);
        });
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

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    "aFynder",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 28.0,
                        fontFamily: 'pacifico'),
                  ),
                  Text(
                    'Sign in with email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        RectFormField(
                          hint: 'Email',
                          isPassword: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid email';
                            } else {
                              email = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        RectFormField(
                          hint: 'Password',
                          isPassword: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid password';
                            } else {
                              password = value;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        SizedBox(
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
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          )),
                                      SizedBox(
                                        width: 16.0,
                                      ),
                                      Text(
                                        "Signing In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                            color: ThemeColors.themeOrange,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                signIn();
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  Center(
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        "Not a member? Sign-up now",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RectFormField extends StatelessWidget {
  final String hint;
  final Function validator;
  final bool isPassword;

  const RectFormField({this.hint, this.validator, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: new InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 18.0),
          border: new OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          fillColor: Colors.grey[200]),
    );
  }
}
