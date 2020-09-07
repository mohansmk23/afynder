import 'package:afynder/constants/colors.dart';
import 'package:afynder/screens/home_screen.dart';
import 'package:afynder/screens/nearme_screen.dart';
import 'package:afynder/screens/offermap_screen.dart';
import 'package:afynder/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> _currentScreens = [
    HomeScreen(),
    NearMe(),
    OfferMap(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.themeColor5,
        leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Icon(FontAwesome.user_circle)),
        title: Text(
          "aFynder",
          style: TextStyle(fontFamily: 'kalam'),
        ),
        elevation: 0,
        actions: <Widget>[Icon(Icons.search)],
      ),
      body: Stack(
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
    );
  }
}
