import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/product_details_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'connectmerchant.dart';
import 'nearme_screen.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  const ProductDetails({Key key, this.productId}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;
  ProductDetailsModel model = ProductDetailsModel();
  ProductList product = ProductList();

  void getProductDetails() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers["authorization"] = prefs.getString(authorizationKey);

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "productList",
        "productId": widget.productId,
        "searchString": "",
        "mobileUniqueCode": mobileUniqueCode
      });
      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = ProductDetailsModel.fromJson(parsed);
        product = model.productList[0];
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
    getProductDetails();
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
        title: Text(""),
        elevation: 0,
        actions: <Widget>[
          Visibility(
            visible: product.isOffer == "yes",
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 6.0),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
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
                            PageView.builder(
                              physics: BouncingScrollPhysics(),
                              controller: controller,
                              itemCount: product.productImages.length - 1,
                              itemBuilder: (BuildContext context, int index) {
                                return FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  fadeInDuration: Duration(seconds: 1),
                                  image: product.productImages[index],
                                  fit: BoxFit.fill,
                                );
                              },
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
                            Visibility(
                              visible: product.isOffer == "yes",
                              child: Positioned(
                                bottom: 30.0,
                                right: 16.0,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "${product.offerAmount}% OFF",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  color: ThemeColors.themeOrange,
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Text(
                                            product.shopCategoryName,
                                            style: TextStyle(
                                              color: ThemeColors.themeColor5,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            product.productName,
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
                                                itemBuilder: (context, index) =>
                                                    Icon(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 14.0, 0, 2),
                                            child: Text(
                                              product.isOffer == "yes"
                                                  ? "Rs. ${product.actualAmount}"
                                                  : "",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: ThemeColors.themeColor5,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Rs. ${product.sellingAmount}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        product.shortDescription,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: product.features.isEmpty
                                              ? 0
                                              : product.features.length - 1,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            print(product.features.length);

                                            return new Column(
                                              children: <Widget>[
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
                                                      product.features[index],
                                                      style: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      ListView.builder(
                                          padding: EdgeInsets.only(top: 0),
                                          shrinkWrap: true,
                                          itemCount:
                                              product.specifications.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 4,
                                                        child: Text(
                                                          product
                                                              .specifications[
                                                                  index]
                                                              .key,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )),
                                                    Expanded(
                                                        flex: 6,
                                                        child: Text(
                                                          product
                                                              .specifications[
                                                                  index]
                                                              .value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        )),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 1.0,
                                                ),
                                              ],
                                            );
                                          })
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
                                            decoration:
                                                TextDecoration.underline,
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
