import 'dart:convert';

import 'package:afynder/constants/api_urls.dart';
import 'package:afynder/constants/colors.dart';
import 'package:afynder/constants/connection.dart';
import 'package:afynder/constants/sharedPrefManager.dart';
import 'package:afynder/constants/strings.dart';
import 'package:afynder/response_models/merchant_details.dart';
import 'package:afynder/response_models/merchant_product_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'nearme_screen.dart';

class MerchantProfile extends StatefulWidget {
  final String merchantId;

  const MerchantProfile({this.merchantId});

  @override
  _MerchantProfileState createState() => _MerchantProfileState();
}

class _MerchantProfileState extends State<MerchantProfile>
    with TickerProviderStateMixin {
  TabController _controller;
  SharedPrefManager _sharedPrefManager = SharedPrefManager();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  Response response;
  MerchantDetailsModel model = new MerchantDetailsModel();
  MerchantProductsModel productsModel = new MerchantProductsModel();
  List<ProductList> productList = [];
  bool isConnectClicked = false;

  void getMerchantsDetails() async {
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(merchantLocationList, data: {
        "apiMethod": "merchantDetails",
        "merchantId": widget.merchantId,
        "mobileUniqueCode": mobileUniqueCode
      });

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        model = MerchantDetailsModel.fromJson(parsed);
        print(model.toJson());
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

  void getMerchantsProducts() async {
    setState(() {
      isLoading = true;
    });

    dio.options.headers["authorization"] =
        await _sharedPrefManager.getAuthKey();

    try {
      response = await dio.post(allProducts, data: {
        "apiMethod": "productList",
        "merchantId": widget.merchantId,
        "mobileUniqueCode": mobileUniqueCode
      });

      print(response);
      final Map<String, dynamic> parsed = json.decode(response.data);
      if (parsed["status"] == "success") {
        productsModel = MerchantProductsModel.fromJson(parsed);
        productList = productsModel.productList.toList();
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
    getMerchantsDetails();
    getMerchantsProducts();
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  curve: Curves.easeInOutQuint,
                  height: isConnectClicked ? 0.0 : 35.0,
                  width: isConnectClicked ? 0.0 : 140.0,
                  duration: Duration(milliseconds: 200),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () {
                      setState(() {
                        isConnectClicked = !isConnectClicked;
                      });
                    },
                    color: ThemeColors.themeOrange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Interested?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "o",
                        child: isConnectClicked ? Icon(Icons.call) : SizedBox(),
                        onPressed: () {
                          launch(
                              "tel:// ${model.merchantInformations.shopContactNumber}");
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "1",
                        backgroundColor: Colors.indigo,
                        child: isConnectClicked ? Icon(Icons.mail) : SizedBox(),
                        onPressed: () {
                          var url =
                              'sms: ${model.merchantInformations.shopContactNumber}?body=Hey i am interested in your product';
                          launch(url);
                        },
                      ),
                    ),
                    AnimatedContainer(
                      width: isConnectClicked ? 70.0 : 0.0,
                      height: 0.0,
                      duration: Duration(milliseconds: 200),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      height: isConnectClicked ? 50.0 : 0.0,
                      width: isConnectClicked ? 50.0 : 0.0,
                      duration: Duration(milliseconds: 200),
                      child: FloatingActionButton(
                        heroTag: "2",
                        backgroundColor: Colors.green,
                        child: isConnectClicked
                            ? Icon(Icons.directions)
                            : SizedBox(),
                        onPressed: () {
                          launch(
                              "https://www.google.com/maps/dir/?api=1&destination=${model.merchantInformations.lat},${model.merchantInformations.lng}&travelmode=driving");
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: Container(
                          child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                ClipPath(
                                  child: Container(
                                      color: Colors.black.withOpacity(0.8)),
                                  clipper: getClipper(),
                                ),
                                Positioned(
                                  top: 120,
                                  child: Container(
                                      width: 140.0,
                                      height: 140.0,
                                      child: ClipOval(
                                        child: FadeInImage.memoryNetwork(
                                          image: model
                                              .merchantInformations.shopLogo,
                                          placeholder: kTransparentImage,
                                          fadeInDuration: Duration(seconds: 1),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                      )),
                                )
                              ]),
                        ),
                      ),
                      Text(
                        model.merchantInformations.shopName,
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
                        model.merchantInformations.shopCategoryName,
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
                              Row(
                                children: <Widget>[
                                  Text(
                                    model.merchantInformations.rating,
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
                                "${model.merchantInformations.ratingCount} Ratings",
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
                        height: productList.length % 2 == 0
                            ? 260 * productList.length / 2
                            : 260 + 260 * productList.length / 2,
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            info(model),
                            products(productList, context)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isConnectClicked,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConnectClicked = false;
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ));
  }
}

Widget products(List<ProductList> productList, BuildContext context) {
  return GridView.builder(
      padding: EdgeInsets.only(top: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.8),
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      // crossAxisCount: 2,
      itemCount: productList.isEmpty ? 0 : productList.length,
      itemBuilder: (context, index) => NearbyItem(
            imagePath: productList[index].productImages[0],
            productName: productList[index].productName,
            isOffer: productList[index].isOffer == "yes",
            isFeatured: productList[index].isFeature == "yes",
            actualPrice: productList[index].actualAmount,
            price: productList[index].sellingAmount,
            offerPercent: productList[index].offerAmount,
            category: productList[index].shopCategoryName,
            productId: productList[index].productId,
          ));
}

Widget info(MerchantDetailsModel model) {
  return Column(
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
                model.merchantInformations.description,
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
                  model.merchantInformations.shopAddress,
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
                  "${model.merchantInformations.shopOpeningTime} - ${model.merchantInformations.shopClosingTime} }",
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
}

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
