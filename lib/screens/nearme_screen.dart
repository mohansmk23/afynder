import 'package:afynder/constants/colors.dart';
import 'package:afynder/screens/filter_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class NearMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 36.0),
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.only(bottom: 36.0),
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: Text(
                  "Todays Picks",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.filter_list,
                      color: Colors.blue,
                    ),
                    InkWell(
                      onTap: () {
                        showGeneralDialog(
                            barrierColor:
                                Colors.black.withOpacity(0.5), //SHADOW EFFECT
                            transitionBuilder: (context, a1, a2, widget) {
                              return Center(
                                child: Container(child: FilterScreen()),
                              );
                            },
                            transitionDuration: Duration(
                                milliseconds: 200), // DURATION FOR ANIMATION
                            barrierDismissible: true,
                            barrierLabel: 'LABEL',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {
                              return Text('PAGE BUILDER');
                            });
                      },
                      child: Text(
                        " Filter",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NearbyItem(
                  imagePath: "assets/cat1.jpg",
                  productname: "Exclusive....",
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
                    category: "Speakers",
                    visible: true),
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
                    visible: false),
              ),
              Expanded(
                child: NearbyItem(
                    imagePath: "assets/nea2.jpg",
                    productname: "Rings",
                    price: "Rs. 15000",
                    category: "Jewels",
                    visible: true),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NearbyItem(
                    imagePath: "assets/nea3.jpeg",
                    productname: "Sport Shoes",
                    price: "Rs. 25000",
                    category: "Footwears",
                    visible: true),
              ),
              Expanded(
                child: NearbyItem(
                    imagePath: "assets/nea4.jpg",
                    productname: "Perfumes",
                    price: "Rs. 15000",
                    category: "Fashions",
                    visible: false),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NearbyItem(
                    imagePath: "assets/nea5.jpeg",
                    productname: "Fresh juices",
                    price: "Rs. 25000",
                    category: "Snacks",
                    visible: false),
              ),
              Expanded(
                child: NearbyItem(
                    imagePath: "assets/nea6.jpeg",
                    productname: "Vegetables",
                    price: "Rs. 15000",
                    category: "Grocery",
                    visible: true),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NearbyItem extends StatelessWidget {
  final String imagePath, productname, price, category;
  final bool visible;

  const NearbyItem(
      {this.imagePath,
      this.productname,
      this.price,
      this.visible,
      @required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 2.0,
                    right: 2.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 4.0,
                    right: 4.0,
                    child: Visibility(
                      visible: visible,
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          productname,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          category,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Visibility(
                          visible: visible,
                          child: Text(
                            "Rs.25000",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
