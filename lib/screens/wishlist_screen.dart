import 'package:flutter/material.dart';

import 'home_screen.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "WishList",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Dismissible(
                    key: Key("1"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cat1.jpg",
                        merchantName: 'Exclusive sofaset',
                        productname: "Furnitures",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("2"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho1.jpeg",
                        merchantName: 'JBL Speakers',
                        productname: "Electronics",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("3"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho5.jpg",
                        merchantName: 'Kitchen Decoratives',
                        productname: "Interiors",
                        price: "Rs. 40000"),
                  ),
                  Dismissible(
                    key: Key("4"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho2.jpeg",
                        merchantName: 'Beats Earphones',
                        productname: "Earphones",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("5"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho3.jpeg",
                        merchantName: 'Aviator Shades',
                        productname: "shades",
                        price: "Rs. 8000"),
                  ),
                  Dismissible(
                    key: Key("6"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho4.jpg",
                        merchantName: 'Electronic Appliances',
                        productname: "Electronics",
                        price: "Rs. 5000"),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
