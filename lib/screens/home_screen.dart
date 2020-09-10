import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/homesccreen_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;

  List<ChoosenList> choiceList = [];
  List<ProductList> featuredList = [];

  void getProducts() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers["authorization"] = prefs.getString(authorizationKey);

    try {
      response = await dio.post(homeScreen, data: {
        "apiMethod": "featureList",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        final HomeScreenModel model = HomeScreenModel.fromJson(parsed);
        choiceList = model.choosenList.toList();
        featuredList = model.productList.toList();
      } else {
        _showSnackBar(parsed["message"]);
      }
    } catch (e) {
      _showSnackBar("Network Error");
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
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
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            featuredList.isEmpty ? 0 : featuredList.length - 1,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new FeaturedItem(
                            imagePath: featuredList[index].productImages[0],
                            name: featuredList[index].productName,
                            visible: featuredList[index].isOffer == "yes",
                            offerPercent: featuredList[index].offerAmount,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
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
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            choiceList.isEmpty ? 0 : choiceList.length - 1,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new ChoiceItem(
                            imagePath: choiceList[index].productImages[0],
                            productName: choiceList[index].productName,
                            isOffer: choiceList[index].isOffer == "yes",
                            offerPercent: choiceList[index].offerAmount,
                            actualPrice: choiceList[index].actualAmount,
                            price: choiceList[index].sellingAmount,
                            categoryName: choiceList[index].shopCategoryName,
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  final String imagePath,
      categoryName,
      productName,
      price,
      offerPercent,
      actualPrice;
  final bool isOffer;

  const ChoiceItem(
      {this.imagePath,
      this.categoryName,
      this.productName,
      this.price,
      this.isOffer,
      this.offerPercent,
      this.actualPrice});

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
                  FadeInImage.memoryNetwork(
                    image: imagePath,
                    placeholder: kTransparentImage,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.fitWidth,
                  ),
                  Visibility(
                    visible: isOffer,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "$offerPercent% OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          color: ThemeColors.themeOrange,
                        )),
                  )
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
                          productName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          categoryName,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      isOffer
                          ? Text(
                              "Rs. $actualPrice",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  decoration: TextDecoration.lineThrough),
                            )
                          : SizedBox(),
                      Text(
                        "Rs. $price",
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
  final String imagePath, name, offerPercent;
  final bool visible;

  const FeaturedItem(
      {this.imagePath, this.name, this.visible, this.offerPercent});

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
                FadeInImage.memoryNetwork(
                  fadeInDuration: Duration(seconds: 1),
                  image: imagePath,
                  placeholder: kTransparentImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
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
                            "$offerPercent% OFF",
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
