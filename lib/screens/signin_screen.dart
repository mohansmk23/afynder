import 'package:flutter/material.dart';
import 'package:afynder/main.dart';
import '../constants/colors.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          height: 24.0,
                        ),
                        RectFormField(
                          hint: 'Password',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid password';
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
                                setState(() {
                                  isLoading = !isLoading;
                                  Navigator.pushNamed(context, '/categories');
                                });
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

  const RectFormField({this.hint, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      textAlign: TextAlign.start,
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
