import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/main.dart';
import 'package:afynder/screens/categories_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afynder/screens/signin_screen.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landing_screen.dart';
import 'nointernet_screen.dart';

class SignUpScreen extends StatefulWidget {
  static var routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _terms = false, isLoading = false;
  String fName, lName, email, mobile, password;
  Response response;
  String termsUrl = 'http://dev.afynder.com/afynder/termsandconditions';

  void signUp() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushNamed(context, NoInternet.routeName);

      return;
    }
    setState(() {
      isLoading = true;
    });
    Map<String, String> params = {
      "apiMethod": "addNewShoppe",
      "firstName": fName,
      "lastName": lName,
      "phoneNumber": mobile,
      "emailId": email,
      "password": password,
      "mobileUniqueCode": "jana1221"
    };

    try {
      print(json.encode(params));
      response = await dio.post(signUpRequest, data: params);
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(firstNameKey, fName);
        prefs.setString(lastNameKey, lName);
        prefs.setString(mailIdKey, email);
        prefs.setString(shopeeId, parsed["shopeeId"]);
        prefs.setBool(isSignnedIn, true);
        prefs.setString(authorizationKey, parsed['authKey']);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Categories.routeName, (Route<dynamic> route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
          builder: (context) => SafeArea(
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
                            height: 12.0,
                          ),
                          Text(
                            "aFynder",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 28.0,
                                fontFamily: 'pacifico'),
                          ),
                          Text(
                            'Sign up to afynder',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: LabelFormField(
                                        label: 'First Name',
                                        keyboardType: TextInputType.text,
                                        isPassword: false,
                                        isMobile: false,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter First Name';
                                          } else {
                                            fName = value;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      child: LabelFormField(
                                        label: 'Last Name',
                                        isMobile: false,
                                        keyboardType: TextInputType.text,
                                        isPassword: false,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Last Name';
                                          } else {
                                            lName = value;
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                LabelFormField(
                                  label: 'Email ID',
                                  isPassword: false,
                                  isMobile: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (!RegExp(
                                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                        .hasMatch(value)) {
                                      return 'Please enter valid Email ID';
                                    } else {
                                      email = value;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                LabelFormField(
                                  label: 'Mobile Number',
                                  isMobile: true,
                                  keyboardType: TextInputType.phone,
                                  isPassword: false,
                                  validator: (value) {
                                    if (value.length != 10) {
                                      return 'Please enter valid Mobile Number';
                                    } else {
                                      mobile = value;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                LabelFormField(
                                  label: 'Password',
                                  isMobile: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid Password';
                                    } else if (value.toString().length < 8) {
                                      return 'Password must be atleast 8 characters';
                                    } else {
                                      password = value;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                LabelFormField(
                                  label: 'Confirm Password',
                                  isMobile: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  isPassword: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please re-enter your Password!';
                                    } else if (value != password) {
                                      return 'Password and Confirm Password doesn\'t match!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                CheckboxListTile(
                                  title: InkWell(
                                    onTap: () {
                                      launch(termsUrl);
                                    },
                                    child: Wrap(
                                      children: <Widget>[
                                        Text(
                                          "I agree to the Terms and Conditions & privacy policy",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                  ),
                                  value: _terms,
                                  onChanged: (newval) {
                                    setState(() {
                                      _terms = newval;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 16.0,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                  width: 22.0,
                                                  height: 22.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.white),
                                                  )),
                                              SizedBox(
                                                width: 16.0,
                                              ),
                                              Text(
                                                "Signing Up",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                    color: ThemeColors.themeOrange,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        if (_terms) {
                                          setState(() {
                                            signUp();
                                          });
                                        } else {
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Please Accept Terms & Conditions')));
                                        }
                                      }

                                      //  Navigator.pushNamed(context, '/dashboard');
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/signin'),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Already have an account ?',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Login Here',
                                    style: TextStyle(
                                        color: Color(0xfff79c4f),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}

class LabelFormField extends StatelessWidget {
  final String label;
  final Function validator;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isMobile;

  const LabelFormField(
      {this.label,
      this.validator,
      this.keyboardType,
      this.isPassword,
      this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4.0,
        ),
        TextFormField(
          validator: validator,
          textAlign: TextAlign.start,
          keyboardType: keyboardType,
          obscureText: isPassword,
          textInputAction: TextInputAction.next,
          maxLength: isMobile ? 10 : null,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          decoration: new InputDecoration(
              prefixIcon: isMobile
                  ? Text(
                      " +91 ",
                      style: TextStyle(fontSize: 16.0),
                    )
                  : null,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
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
        )
      ],
    );
  }
}
