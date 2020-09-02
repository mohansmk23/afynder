import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'connectmerchant.dart';
import 'nearme_screen.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController();

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
        title: Text(""),
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: ThemeColors.themeOrange,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      "Featured",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: ListView(
              padding: EdgeInsets.only(top: 0, bottom: 36.0),
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.1,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      PageView(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        children: <Widget>[
                          Image.asset(
                            'assets/fea1.jpg',
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            'assets/chair.jpeg',
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            'assets/fea1.jpg',
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 36.0,
                        left: 16.0,
                        child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: ExpandingDotsEffect(
                                spacing: 4.0,
                                radius: 5.0,
                                dotWidth: 10.0,
                                activeDotColor: Colors.blue,
                                dotHeight: 10.0), // your preferred effect
                            onDotClicked: (index) {}),
                      ),
                      Positioned(
                        bottom: 30.0,
                        right: 16.0,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "20% OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          color: ThemeColors.themeOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0.0, -24.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      "Furnitures",
                                      style: TextStyle(
                                        color: ThemeColors.themeColor5,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      "Exclusive Chair",
                                      style: TextStyle(
                                          color: ThemeColors.themeColor5,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        RatingBarIndicator(
                                          rating: 3.35,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          direction: Axis.horizontal,
                                        ),
                                        Text(
                                          "587 Ratings",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 14.0, 0, 2),
                                      child: Text(
                                        "Rs. 25000",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: ThemeColors.themeColor5,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Rs. 12500",
                                      style: TextStyle(
                                        color: ThemeColors.themeColor5,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8.0, 0, 2),
                                      child: Icon(Icons.bookmark_border),
                                    ),
                                  ],
                                )
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
                                  "Description",
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
                                  "Features",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ThemeColors.themeColor5,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.circle,
                                      size: 8.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Teak wood",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.circle,
                                      size: 8.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "WaterProof Ipv4 certification",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.circle,
                                      size: 8.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Ceramic laminated ",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.circle,
                                      size: 8.0,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Extra life",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
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
                                  "Specifications",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: ThemeColors.themeColor5,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Model Name",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                          "CHA-8679",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Color",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                          "Active Black",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Type",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                          "Foldable",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Design",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Text(
                                          "Vintage belt",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Products from the seller",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: ThemeColors.themeColor5,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/merchantdetails');
                                },
                                child: Text(
                                  "View Seller Info",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ThemeColors.themeColor5,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: NearbyItem(
                                imagePath: "assets/cat1.jpg",
                                productname: "Exclusi...",
                                price: "Rs. 25000",
                                category: "Furnitures",
                                visible: true,
                              ),
                            ),
                            Expanded(
                              child: NearbyItem(
                                imagePath: "assets/cho1.jpeg",
                                productname: "JBL Speakers",
                                price: "Rs. 15000",
                                visible: true,
                                category: "Speakers",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: NearbyItem(
                                imagePath: "assets/nea1.jpeg",
                                productname: "Earings",
                                price: "Rs. 25000",
                                category: "Jewels",
                                visible: false,
                              ),
                            ),
                            Expanded(
                              child: NearbyItem(
                                imagePath: "assets/nea2.jpg",
                                productname: "Rings",
                                price: "Rs. 15000",
                                category: "Jewels",
                                visible: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
