import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 10,
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
                        'Lorem ipsum dolor sit ',
                        style: TextStyle(
                            color: ThemeColors.themeColor5,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'amet, consectetur',
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
                              : _sliderCurrentIndex > 0 ? 1.0 : 0,
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
                              : _sliderCurrentIndex > 1 ? 1.0 : 0,
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
                              : _sliderCurrentIndex == 2 ? 1.0 : 0,
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
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SocialMediaButton(
                            text: "Google",
                            prefixIcon: Icon(
                              FontAwesome.google,
                              color: Colors.white,
                            ),
                            buttonColor: Colors.blueAccent,
                            onTap: () {
                              _googleSignIn.signIn();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: SocialMediaButton(
                            text: "Facebook",
                            prefixIcon: Icon(
                              FontAwesome.facebook,
                              color: Colors.white,
                            ),
                            buttonColor: Colors.blue[800],
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
                            child: Container(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          "OR USING EMAIL",
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(6.0, 6.0, 0.0, 6.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        EmailSignButton(
                          text: "Sign in",
                          onpressed: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        EmailSignButton(
                          text: "Sign up",
                          onpressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
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
    return Expanded(
      child: RaisedButton(
        onPressed: onpressed,
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        )),
        textColor: Colors.white,
        color: ThemeColors.themeOrange,
        padding: EdgeInsets.all(12.0),
      ),
    );
  }
}
