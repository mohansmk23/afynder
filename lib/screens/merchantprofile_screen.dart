import 'package:afynder/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'nearme_screen.dart';

class MerchantProfile extends StatefulWidget {
  @override
  _MerchantProfileState createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0, color: Colors.white),
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          backgroundColor: ThemeColors.themeOrange,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(FontAwesome.whatsapp),
              backgroundColor: Colors.green,
              label: 'WhatsApp',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.email),
              backgroundColor: Colors.blue,
              label: 'Mail',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
                child: Icon(Icons.phone),
                backgroundColor: Colors.red,
                label: 'Call',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('FIRST CHILD')),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  height: 300,
                  child: Container(
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      ClipPath(
                        child: Container(color: Colors.black.withOpacity(0.8)),
                        clipper: getClipper(),
                      ),
                      Positioned(
                        top: 120,
                        child: Container(
                            width: 140.0,
                            height: 140.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                image: new ExactAssetImage(
                                    'assets/profileavatar.jpg'),
                                fit: BoxFit.cover,
                              ),
                            )),
                      )
                    ]),
                  ),
                ),
                Text(
                  "Manoj Furnitures",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ThemeColors.themeColor5,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Furniture Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "184",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ThemeColors.themeColor5,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.themeColor5,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      width: 1.0,
                      height: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ThemeColors.themeColor5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellowAccent,
                            )
                          ],
                        ),
                        Text(
                          "154 Ratings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.themeColor5,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Card(
                  child: Container(
                    child: TabBar(controller: _controller, tabs: [
                      Tab(
                        child: Text(
                          "Info",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Products",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  height: 500.0,
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[info, products],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

Widget products = Column(
  children: <Widget>[
    Row(
      children: <Widget>[
        Expanded(
          child: NearbyItem(
            imagePath: "assets/cat1.jpg",
            productName: "Exclusive...",
            price: "Rs. 25000",
            category: "Furnitures",
            isOffer: true,
          ),
        ),
        Expanded(
          child: NearbyItem(
            imagePath: "assets/cho1.jpeg",
            productName: "JBL Speakers",
            category: "Speakers",
            price: "Rs. 15000",
            isOffer: true,
          ),
        ),
      ],
    ),
    Row(
      children: <Widget>[
        Expanded(
          child: NearbyItem(
            imagePath: "assets/nea1.jpeg",
            productName: "Earings",
            price: "Rs. 25000",
            category: "Jewels",
            isOffer: false,
          ),
        ),
        Expanded(
          child: NearbyItem(
            imagePath: "assets/nea2.jpg",
            productName: "Rings",
            price: "Rs. 15000",
            category: "Jewels",
            isOffer: true,
          ),
        ),
      ],
    ),
  ],
);

Widget info = Column(
  children: <Widget>[
    Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "INFO",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ThemeColors.themeColor5,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor ddfjhfjfhjhdfjfhjdfh",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ThemeColors.themeColor5,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ),
    Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "ADDRESS",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: ThemeColors.themeColor5,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              "L23/38, Westcott Rd, Royapettah, Chennai, Tamil Nadu 600014",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: ThemeColors.themeColor5,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ),
    SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "WORKING HOURS",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: ThemeColors.themeColor5,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Mon - Sat 8:30 AM - 9:00 Pm",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: ThemeColors.themeColor5,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width + 130, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
