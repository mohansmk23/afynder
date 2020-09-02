import 'package:afynder/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'landing_screen.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                        text: "Sign-up with Google",
                        prefixIcon: Icon(
                          FontAwesome.google,
                          color: Colors.white,
                        ),
                        buttonColor: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 48.0,
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                              child: Icon(
                            FontAwesome.facebook,
                            color: Colors.grey[600],
                          )),
                        ),
                      ),
                    )
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                        child: Container(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      "Or",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
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
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: LabelFormField(
                            label: 'First Name',
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Flexible(
                          child: LabelFormField(
                            label: 'Last Name',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                LabelFormField(
                  label: 'Email',
                ),
                SizedBox(
                  height: 16.0,
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
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    color: ThemeColors.themeOrange,
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                ),
                SizedBox(
                  height: 24.0,
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
          ),
        ),
      ),
    );
  }
}
