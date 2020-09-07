import 'package:afynder/constants/colors.dart';
import 'package:afynder/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afynder/screens/signin_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'landing_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _terms = false, isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: SocialMediaButton(
                                    text: "Google",
                                    prefixIcon: Icon(
                                      FontAwesome.google,
                                      color: Colors.white,
                                    ),
                                    buttonColor: Colors.blue,
                                    onTap: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: SocialMediaButton(
                                    text: "Facebook",
                                    prefixIcon: Icon(
                                      FontAwesome.facebook,
                                      color: Colors.white,
                                    ),
                                    buttonColor: Colors.blueAccent,
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                                    child: Container(
                                      height: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Or",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16.0),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                    child: Container(
                                      height: 1.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
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
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter first name';
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
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter last name';
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
                                    label: 'Email',
                                    validator: (value) {
                                      if (!RegExp(
                                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                          .hasMatch(value)) {
                                        return 'Please enter valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  LabelFormField(
                                    label: 'Mobile',
                                    validator: (value) {
                                      if (value.length != 10) {
                                        return 'Please enter valid mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  LabelFormField(
                                    label: 'Password',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      "I agree to the Terms and Conditions & privacy policy",
                                      style: TextStyle(fontSize: 15.0),
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
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
                                              isLoading = !isLoading;
                                              Navigator.pushNamed(
                                                  context, '/categories');
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
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signin');
                                },
                                child: Text(
                                  "Already a member? sign in",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}

class LabelFormField extends StatelessWidget {
  final String label;
  final Function validator;

  const LabelFormField({this.label, this.validator});

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
          decoration: new InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
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
