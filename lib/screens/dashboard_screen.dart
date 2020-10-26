import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/screens/home_screen.dart';
import 'package:afynder/screens/nearme_screen.dart';
import 'package:afynder/screens/offermap_screen.dart';
import 'package:afynder/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class Dashboard extends StatefulWidget {
  static const routeName = "/dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  DateTime currentBackPressTime;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();
  Widget profileImage;
  String categorySelection = defaultProductsFilter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _showSnackBar("Press Back to Exit");
      return Future.value(false);
    }
    SystemNavigator.pop(animated: true);
    return Future.value(true);
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        duration: Duration(seconds: 1), content: new Text(message)));
  }

  List<Widget> _currentScreens = [];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  checkLogin() async {
    if (!await _sharedPrefManager.iSignedIn()) {
      Navigator.pushNamed(context, '/');
    }
  }

  navigateToProfileOrLanding() async {
    if (await _sharedPrefManager.iSignedIn()) {
      Navigator.pushNamed(context, ProfileScreen.routeName);
    } else {
      Navigator.pushNamed(context, '/');
    }
  }

  getProfileImage() async {
    if (await _sharedPrefManager.iSignedIn()) {
      if (await _sharedPrefManager.getProfileImageUrl() != "") {
        profileImage = Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 4.0,
            backgroundImage:
                NetworkImage(await _sharedPrefManager.getProfileImageUrl()),
          ),
        );
      } else {
        profileImage = Icon(FontAwesome.user_circle);
      }
    } else {
      profileImage = Icon(FontAwesome.user_circle);
    }

    setState(() {});
  }

  @override
  void initState() {
    checkLogin();
    getProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentScreens = [
      HomeScreen(
        popularCategorySelection: (selection) {
          categorySelection = selection;
          _onItemTapped(1);
        },
      ),
      NearMe(
        categorySelection: categorySelection,
      ),
      OfferMap(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ThemeColors.themeColor5,
        leading: InkWell(
            onTap: () {
              navigateToProfileOrLanding();
            },
            child: profileImage),
        title: Text(
          "aFynder",
          style: TextStyle(fontFamily: 'courgette'),
        ),
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: <Widget>[
            _currentScreens.elementAt(_currentIndex),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _onItemTapped(0);
                            });
                          },
                          child: Icon(
                            Ionicons.md_home,
                            color: ThemeColors.themeOrange,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                categorySelection = defaultProductsFilter;
                                _onItemTapped(1);
                              });
                            },
                            child: Icon(Ionicons.ios_locate,
                                color: ThemeColors.themeOrange)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _onItemTapped(2);
                              });
                            },
                            child: Icon(MaterialIcons.map,
                                color: ThemeColors.themeOrange)),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
