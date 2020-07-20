import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(fit: StackFit.expand, children: <Widget>[
              Image.network(
                'https://wallpaperaccess.com/full/1455126.jpg',
                fit: BoxFit.fill,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "aFynder",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontFamily: 'pacifico'),
                      ),
                      Text(
                        'Lorem ipsum dolor sit ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'amet, consectetur',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          SocialMediaButton(
            text: "Sign-in with Google",
            prefixIcon: Icon(Icons.mail),
            buttonColor: Colors.blue,
          ),
          SocialMediaButton(
            text: "Sign-in with Facebook",
            prefixIcon: Icon(Icons.face),
            buttonColor: Colors.blueAccent,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 8.0),
                    child: Container(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  "OR USING EMAIL",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                    child: Container(
                      height: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                EmailSignButton(
                  text: "Sign in",
                ),
                SizedBox(
                  width: 16.0,
                ),
                EmailSignButton(
                  text: "Sign up",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String text;
  final Icon prefixIcon;
  final Color buttonColor;

  const SocialMediaButton({this.text, this.prefixIcon, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: RaisedButton(
          onPressed: () {},
          padding: EdgeInsets.all(8.0),
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
                    TextStyle(color: ThemeColors.themeColor4, fontSize: 18.0),
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

  const EmailSignButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        onPressed: () {},
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        )),
        textColor: Colors.white,
        color: ThemeColors.themeColor1,
        padding: EdgeInsets.all(14.0),
      ),
    );
  }
}
