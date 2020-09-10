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
                        categoryName: 'Exclusive sofaset',
                        productName: "Furnitures",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("2"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho1.jpeg",
                        categoryName: 'JBL Speakers',
                        productName: "Electronics",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("3"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho5.jpg",
                        categoryName: 'Kitchen Decoratives',
                        productName: "Interiors",
                        price: "Rs. 40000"),
                  ),
                  Dismissible(
                    key: Key("4"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho2.jpeg",
                        categoryName: 'Beats Earphones',
                        productName: "Earphones",
                        price: "Rs. 25000"),
                  ),
                  Dismissible(
                    key: Key("5"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho3.jpeg",
                        categoryName: 'Aviator Shades',
                        productName: "shades",
                        price: "Rs. 8000"),
                  ),
                  Dismissible(
                    key: Key("6"),
                    background: Container(color: Colors.red),
                    child: ChoiceItem(
                        imagePath: "assets/cho4.jpg",
                        categoryName: 'Electronic Appliances',
                        productName: "Electronics",
                        price: "Rs. 5000"),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
