import 'package:afynder/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: ListView(children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            'Select Categories',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat1.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Furnitures",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat2.jpeg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Electronics",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat3.jpeg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Kitchen",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat4.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Dresses",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat1.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Furnitures",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat2.jpeg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Electronics",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat3.jpeg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Kitchen",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 150.0,
                  width: double.infinity,
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/cat4.jpg',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: Color.fromRGBO(255, 255, 255, 0.19),
                          ),
                          Center(
                            child: Text(
                              "Dresses",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: ThemeColors.themeOrange,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Select 0 categories",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ]),
      ),
    ));
  }
}
