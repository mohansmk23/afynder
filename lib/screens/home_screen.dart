import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(bottom: 48.0),
        children: <Widget>[
          Container(
            color: ThemeColors.themeOrange,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "LOCATION",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Royapettah ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  "FEATURED",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "View All",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 8.0),
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FeaturedItem(
                  imagePath: 'assets/fea1.jpg',
                  name: 'Chair',
                  visible: true,
                ),
                FeaturedItem(
                  imagePath: 'assets/fea2.jpg',
                  name: 'Photo Frame',
                  visible: false,
                ),
                FeaturedItem(
                  imagePath: 'assets/fea3.jpg',
                  name: 'Cookery',
                  visible: true,
                ),
                FeaturedItem(
                  imagePath: 'assets/fea4.jpg',
                  name: 'Shades',
                  visible: true,
                ),
                FeaturedItem(
                  imagePath: 'assets/fea5.jpg',
                  name: 'Sofa',
                  visible: false,
                ),
                FeaturedItem(
                  imagePath: 'assets/fea6.jpg',
                  name: 'Bed',
                  visible: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  "CHOICE",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "View All",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ChoiceItem(
                    imagePath: "assets/cat1.jpg",
                    merchantName: 'Exclusive sofaset',
                    productname: "Furnitures",
                    price: "Rs. 25000"),
                ChoiceItem(
                    imagePath: "assets/cho1.jpeg",
                    merchantName: 'JBL Speakers',
                    productname: "Electronics",
                    price: "Rs. 25000"),
                ChoiceItem(
                    imagePath: "assets/cho5.jpg",
                    merchantName: 'Kitchen Decoratives',
                    productname: "Interiors",
                    price: "Rs. 40000"),
                ChoiceItem(
                    imagePath: "assets/cho2.jpeg",
                    merchantName: 'Beats Earphones',
                    productname: "Earphones",
                    price: "Rs. 25000"),
                ChoiceItem(
                    imagePath: "assets/cho3.jpeg",
                    merchantName: 'Aviator Shades',
                    productname: "shades",
                    price: "Rs. 8000"),
                ChoiceItem(
                    imagePath: "assets/cho4.jpg",
                    merchantName: 'Electronic Appliances',
                    productname: "Electronics",
                    price: "Rs. 5000")
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  final String imagePath, merchantName, productname, price;

  const ChoiceItem(
      {this.imagePath, this.merchantName, this.productname, this.price});

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
                    fit: BoxFit.fitWidth,
                  ),
                  Align(
                      alignment: Alignment.topRight,
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
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          merchantName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          productname,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: <Widget>[
                      Text(
                        'Rs 70000',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                            color: ThemeColors.themeColor5, fontSize: 14.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8.0,
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

class FeaturedItem extends StatelessWidget {
  final String imagePath, name;
  final bool visible;

  const FeaturedItem({this.imagePath, this.name, this.visible});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/productdetails');
        },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  color: Color.fromRGBO(255, 255, 255, 0.19),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
                Visibility(
                  visible: visible,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "20% OFF",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12.0),
                          ),
                        ),
                        color: ThemeColors.themeOrange,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
