import 'package:flutter/material.dart';
import 'package:afynder/main.dart';
import '../constants/colors.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.close,
                color: Colors.grey,
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                "aFynder",
                style: TextStyle(
                    color: Colors.grey, fontSize: 28.0, fontFamily: 'pacifico'),
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
              RectFormField(
                hint: 'Email',
              ),
              SizedBox(
                height: 24.0,
              ),
              RectFormField(
                hint: 'Password',
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
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: ThemeColors.themeColor1,
                  onPressed: () {},
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
                child: Text(
                  "Not a member? Sign-up now",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RectFormField extends StatelessWidget {
  final String hint;

  const RectFormField({this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
