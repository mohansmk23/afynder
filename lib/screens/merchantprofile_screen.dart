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
                        height: productList.length % 2 == 0
                            ? 200 * productList.length / 2
                            : 200 + 200 * productList.length / 2,
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            info(model),
                            products(productList)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }
}

Widget products(List<ProductList> productList) {
  return GridView.builder(
      padding: EdgeInsets.only(top: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
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
